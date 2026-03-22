Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD982D2496;
	Sun, 22 Mar 2026 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774146215; cv=none; b=acJk6z6ivxutosiKo4Xoa7dhiZMyPXhi0gadgpb4UwOfaQa6OFs09mO6/kLTJjNXUpDYqDvobwjnX0WPoubeMbuYst0MFFGf5jTvscPVnNQgrbFNf9AMm8AGv9rIV8qCVoYxg5j0LlH8bKJgGevilRmHVwKUjGox/n+jzPBKgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774146215; c=relaxed/simple;
	bh=4vo/h6YHVIwdKVQ/QQvJAQBHryM/N2t+N2KvHMNiMO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEhEnL8NOl2DdWEGfxAKewUDOYzSqYlui2lM6td5Asq2yc1w1h05TXxBfyX8xw+9shnAJeVV/jx0IdPRnBYhrs5xYrK3e5sVNfLJsL1ieOkHacpIdCkdfmpvfVYypoYV0IiSWr1Tu82dkWDp7ipNnUGeJ2D67q1zhg+jxfuys2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JNguzBEo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JNguzBEo"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LKkYJf1829803;
	Sun, 22 Mar 2026 02:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CPvyT85aQX28/6x6P3my1KWFDq8/t1
	+3vnYHDCA91ik=; b=JNguzBEoBpizWgSXo5xYtqsA9JIa6GCJqz0JVdN0/5IZLQ
	DV/5aTCsjI9NxPqZgtk6NRAIO+woKGCzOFEpLpX3kHOX+PCa6gfG70s4eY3nzIqR
	sFT4YC2MR6bDF601Pl+CKJmtpZwSBSvWYHVROml6fiKI0LTf1llZQKwFTA4fXw1I
	nDFqKwybhYfY7J/js822AFTjQr1dOAVqR24GxZiMlW1kl+IljnV0UuCLwi9CfccB
	ddsFem2Bw0cFMmWiIhqNnQ+4L8HPVW2szcplg2dk+M9oaeiNcr57QJnfzUXpcT+K
	OPw21FyGx8DLxiaPMMTZHpczw8BF6zJ6nrC5rxyw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9jfne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 02:23:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LMUNoM012784;
	Sun, 22 Mar 2026 02:23:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1w90y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 02:23:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62M2NKaV30474694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Mar 2026 02:23:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AB1520043;
	Sun, 22 Mar 2026 02:23:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27D5F20040;
	Sun, 22 Mar 2026 02:23:20 +0000 (GMT)
Received: from localhost (unknown [9.111.74.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 22 Mar 2026 02:23:20 +0000 (GMT)
Date: Sun, 22 Mar 2026 03:23:18 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: syzbot <syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in bio_alloc_bioset
Message-ID: <ttca3yu@ub.hpns>
References: <ttc9u7u@ub.hpns>
 <69bf3539.050a0220.3bf4de.006a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69bf3539.050a0220.3bf4de.006a.GAE@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jje7i1mwpQZGiz087lq5f5gmwK01bU6F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDAxNyBTYWx0ZWRfXz8j6ymP5BUos
 UHpwVDBAKEYo5Sy296NdCKZLNz4Sw8y/9U7waywZMfPBNuBQ0gvhpkMKYP6Ld8oHUj/7elyaEoe
 Wxuc+/AzWWTGEc/O3AQsGh+OuklHkwcj8yJr1oL9Go69xIJa9mAyy18PtzaI1ZDXgOeEclEtbmy
 7S0/W2D/liGblcMrSxBJlcz22oyHoQIaxb0Hle24tHG/alq1FODLQOXePUoy2EN+LjtVnx4Qdtm
 iDCVBhzRUddNmV/5s6xVZK+BpmNi8tUObrWV8HYqXgfpSAD3HRUQISfqEoWRhOywTNzI9CGB6hf
 bqW1cU9NVfY2tSRjAyRbI6OMxdRl7PQ+KvX8VjBdOlOhCLn7lDl0a0hxYcqAvZFXznSIL79f4Eh
 vs6lG1jv+r1asW6cmRhS3nPOJZ6Dm1JTYCay8ewATa+1RCypOgPGUsflALJ94Oajo7rSPhOameZ
 G31wG6rB+v9LszOln6Q==
X-Proofpoint-GUID: jje7i1mwpQZGiz087lq5f5gmwK01bU6F
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69bf529b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=edf1wS77AAAA:8
 a=gNbmwd2WZE6oeA4uFWwA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_08,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603220017

On Sat, Mar 21, 2026 at 05:18:01PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> SYZFAIL: failed to recv rpc
> 
> SYZFAIL: failed to recv rpc
> fd=3 want=4 recv=0 n=0 (errno 9: Bad file descriptor)
> 
> 
> Tested on:
> 
> commit:         785f0eb2 Add linux-next specific files for 20260320
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1385ccba580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=22bf3527036b9be1
> dashboard link: https://syzkaller.appspot.com/bug?extid=09ddb593eea76a158f42
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=143881d6580000

Well, keeping in mind that the repro does

ioctl$BLKTRACESETUP(r1, 0xc0481273, &(0x7f00000001c0)={'\x00', 0x1, 0x18148795, 0x7, 0x6})

that is roughly 2.6 GiB per CPU of relay buffer on an ~8 GiB VM with tiny
swap. Surviving 1h15m before syzbot loses it is about as good as it gets.
