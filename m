Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B47DA8C;
	Tue, 20 May 2025 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747710087; cv=none; b=XSZEeHWRXAwAKLqxVivKE813i/5KCAlEpzKWgW4MjgX/MZw0NPgo8TujM7b4nQmb8Cx7HFwzDHw4OnzjdCteVoebjjue74oBxeuojY26uZRXfTaT1Z0eRczOz/xfLyg2RlCCyRgSSecpKcs0yTWNevL4cz1SPvU8aQM56yozEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747710087; c=relaxed/simple;
	bh=lRUh6dRJtQiZa+8t4FTFdMMIqt30kv8ivVGHDv0gA9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3C2jKsTHY8eABKrNjoYIkVTVbD2wF0EKd39kO/eL8Bb7mF52P2+ltTWG9MkCrXiCI1ukHp4aFmjkNru+C5D++G0zdIpvqcdDgOHt1ykojCpr4D3J91pt5UpRFNAxZgosEf2qdw7aoKihD6fa9xg5E65AnaHzFeu0iQ6TZ880t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K0v2JT030894;
	Mon, 19 May 2025 20:01:01 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46psykjcdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 19 May 2025 20:01:01 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 19 May 2025 20:00:45 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 19 May 2025 20:00:38 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <mail@eworm.de>
CC: <axboe@kernel.dk>, <christian@heusel.eu>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lizhi.xu@windriver.com>, <ming.lei@redhat.com>,
        <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V5] loop: Add sanity check for read/write_iter
Date: Tue, 20 May 2025 11:00:51 +0800
Message-ID: <20250520030051.177205-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519175640.2fcac001@leda.eworm.net>
References: <20250519175640.2fcac001@leda.eworm.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=a8kw9VSF c=1 sm=1 tr=0 ts=682bf06d cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=dt9VzEwgFbYA:10 a=fxJcL_dCAAAA:8 a=pyFgNqfGdhKnyIgsGAYA:9
X-Proofpoint-GUID: XAUBDte_tKDZX_vfTPkcByugzcBwCj1t
X-Proofpoint-ORIG-GUID: XAUBDte_tKDZX_vfTPkcByugzcBwCj1t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDAyMyBTYWx0ZWRfX/laEmSf+5Z0d e1vgqhSVMBnDR9uj8XUIbc7RG+srhKEI5xOPLrZDsh8BVp4JplCYajtaMyDZxrttNdls/o2d1zO NP2kl4FeRxa75WWT1DW+qnvxawdoaHitwz4rXLfMH7dZUl9/uKzcnKweQccaVgUyCVbZ1PCCxKq
 hUFaEAvBpicTerFpZEPfa9RGIe2/+EkjIq4h2IFZvmfJcdY7gFeHIhhdCgXruhBa43528Xrs+ZR CWbc/jyh6MVx5eg34ux+cVt7jvEZz0q9ZbKRzKQF17Y4//WYdWa9ydZGIZUlxezhMMxFcOEXF6t dUIO5tQIP7r96HrLJkpMaQaP9+OKx4gpShUMwRIT4LzFCH1aPo1/7ixNLlAzDj/znHSxmYLrWc9
 TUyN43AuXpb4p+urHYxumWb+cV+39LPCwuQwYb1dhgsvhKC8ib999HY59rRmXhAyNLGA2XVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=935 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505200023

On Mon, 19 May 2025 17:56:40 +0200, Christian Hesse wrote:
> $ losetup --find --show --read-only -- /run/archiso/bootmnt/arch/x86_64/airootfs.sfs
> losetup: /run/archiso/bootmnt/arch/x86_64/airootfs.sfs: failed to set up loop device: Invalid argument
I tried to reproduce the problem you mentioned using the kernel containing
"commit:f5c84eff", but failed to reproduce it.
The complete reproduction steps are as follows:

sudo apt install squashfs-tools debootstrap
sudo debootstrap --arch=amd64 focal rootfs http://archive.ubuntu.com/ubuntu/
sudo mksquashfs rootfs rootfs.sfs -comp xz -e boot
root@intel-x86-64:~# losetup --find --show --read-only -- rootfs.sfs
[   79.676267][ T9551] loop0: detected capacity change from 0 to 272400
/dev/loop0
root@intel-x86-64:~# uname -a
Linux intel-x86-64 6.15.0-rc7 #108 SMP PREEMPT_DYNAMIC Mon May 19 09:20:25 CST 2025 x86_64 x86_64 x86_64 GNU/Linux
root@intel-x86-64:~# df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
/dev/root      ext4      3.8G  738M  2.9G  21% /
devtmpfs       devtmpfs  1.5G     0  1.5G   0% /dev
tmpfs          tmpfs     1.5G     0  1.5G   0% /dev/shm
tmpfs          tmpfs     585M   13M  572M   3% /run
tmpfs          tmpfs     4.0M     0  4.0M   0% /sys/fs/cgroup
tmpfs          tmpfs     1.5G     0  1.5G   0% /tmp
tmpfs          tmpfs     1.5G  904K  1.5G   1% /var/volatile
tmpfs          tmpfs     293M     0  293M   0% /run/user/0
root@intel-x86-64:~# ls -lath /dev/loop0
brw-rw---- 1 root disk 7, 0 May 20 02:43 /dev/loop0
root@intel-x86-64:~# mkdir sfs
root@intel-x86-64:~# mount /dev/loop0 sfs
mount: /root/sfs: WARNING: source write-protected, mounted read-only.
root@intel-x86-64:~# df -Th
Filesystem     Type      Size  Used Avail Use% Mounted on
/dev/root      ext4      3.8G  738M  2.9G  21% /
devtmpfs       devtmpfs  1.5G     0  1.5G   0% /dev
tmpfs          tmpfs     1.5G     0  1.5G   0% /dev/shm
tmpfs          tmpfs     585M   13M  572M   3% /run
tmpfs          tmpfs     4.0M     0  4.0M   0% /sys/fs/cgroup
tmpfs          tmpfs     1.5G     0  1.5G   0% /tmp
tmpfs          tmpfs     1.5G  904K  1.5G   1% /var/volatile
tmpfs          tmpfs     293M     0  293M   0% /run/user/0
/dev/loop0     squashfs  134M  134M     0 100% /root/sfs
root@intel-x86-64:~# ls -alt sfs
total 3
drwx------ 21 root root 3072 May 20 02:49 ..
drwxr-xr-x 16 root root  284 May 20 02:20 .
drwxrwxrwt  2 root root    3 May 20 02:20 tmp
drwxr-xr-x 59 root root 2073 May 20 02:20 etc
drwxr-xr-x  8 root root  124 May 20 02:20 run
drwxr-xr-x  2 root root    3 May 20 02:19 media
drwxr-xr-x  2 root root    3 May 20 02:19 mnt
drwxr-xr-x  2 root root    3 May 20 02:19 opt
drwx------  2 root root   46 May 20 02:19 root
drwxr-xr-x  2 root root    3 May 20 02:19 srv
drwxr-xr-x 13 root root  178 May 20 02:19 usr
drwxr-xr-x 11 root root  172 May 20 02:19 var
drwxr-xr-x  4 root root  191 May 20 02:19 dev
lrwxrwxrwx  1 root root    7 May 20 02:19 bin -> usr/bin
lrwxrwxrwx  1 root root    7 May 20 02:19 lib -> usr/lib
lrwxrwxrwx  1 root root    9 May 20 02:19 lib32 -> usr/lib32
lrwxrwxrwx  1 root root    9 May 20 02:19 lib64 -> usr/lib64
lrwxrwxrwx  1 root root   10 May 20 02:19 libx32 -> usr/libx32
lrwxrwxrwx  1 root root    8 May 20 02:19 sbin -> usr/sbin
drwxr-xr-x  2 root root    3 Apr 15  2020 home
drwxr-xr-x  2 root root    3 Apr 15  2020 proc
drwxr-xr-x  2 root root    3 Apr 15  2020 sys

