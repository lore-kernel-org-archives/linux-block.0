Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9EE481226;
	Tue, 14 Jul 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045998; cv=none; b=jQwlvbqO50GODLnd9RcxlwkYhZogY1TkjEHrp1KGTaiy8WTHZD5Afl4hSqiAbrrWBNNWdOSFaZTysgKQC11UacXQCX6dpZfC+NQDG4q4gcAT6HrHu3dswHUajcZst0NgSnC5jzHOLw0WM0MOfY+C8DSecuOM9kaMNpARsStxbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045998; c=relaxed/simple;
	bh=PcmBgqR0/E81Mhlxa6ljMiE++N/yEB5ACH67F3xp3Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5Ddy2mwjVGUjEFRmf4UUN1MIEQUy6to9SWzPsHpGekYXbqB9sOAc+7k1jl5g3stsWyoBO+GqmqQFTSncDY5yCaRYq/75x3P7hnM62aOndRzpc/rj+/lkFpMYKbjrECDQJU0HsqrJckZMnoObco22+napsuW+3jhNa1skyRsD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MePzHdpY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MePzHdpY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EGC0pr1805984;
	Tue, 14 Jul 2026 16:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W3kixr
	ryk6U5dmNNF+YNNGFGvKWYVKeHWS2lbNbw4OQ=; b=MePzHdpYyqiNuy2N1NwXsf
	XHWplxe3c/hb8wxPZHT9kHop3RKbHLRWtgC3tO53jGNXfXCBqyDIxWJFt+ERWfrM
	uQSiFhUwE8/KFVPPtl/mbXaeaVuJZszLauwslKGKd/OxcpW2DwJSi+zE2CmA1T5f
	y/ub713CCwQ/mVFVlLS3lHzegdnx44qQyo9lrnbc5v1yAYP5yaAklTWgf+8LSaNn
	DbNdFxEc0kWH3sraYGhXBWX0oVSSA2gTGZVSL/6/BJ5bZxdpKnMSayFnGoZXmJme
	azKlf6xX8JAnwHyNn6DX9ZTLlqE0hs1gnYCoGE8/MIe9XUf0+EYO1e7IpWHO/D4g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxf5ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 16:19:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EGJcPY014895;
	Tue, 14 Jul 2026 16:19:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgbe9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 16:19:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EGJkwc18350522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 16:19:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11FFD2004D;
	Tue, 14 Jul 2026 16:19:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AADB820043;
	Tue, 14 Jul 2026 16:19:45 +0000 (GMT)
Received: from [9.111.15.51] (unknown [9.111.15.51])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 16:19:45 +0000 (GMT)
Message-ID: <b15b5fcd-441d-40a8-9055-4d232f3780bb@linux.ibm.com>
Date: Tue, 14 Jul 2026 18:19:40 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: reclassify u->iolock of AF_UNIX sockets
To: Josef Bacik <josef@toxicpanda.com>, Eric Dumazet <edumazet@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20260713181401.11088-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260713181401.11088-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Bdm01HZG2189W2hotyunaxbeHSWL-AQm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2OCBTYWx0ZWRfX/7qQUXQpvWQ/
 tA8WcxWAQVN7zXRK+J7Z7wAM9SqEWk/cYyYSC0exW/QD0cnMGSpY+5IpNrRpCo+23Vcgn0YhJXb
 qiWGcEbjFVbBfGdwM8Lvlm1Wn/OPO+4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2OCBTYWx0ZWRfXy97AZxq0qlEp
 9zMuwyJo7J/IeHjCc8m+XgaXu2rke3Bnnk9tQSAb+/ctsraV34DM18t1EXyOpPZ8L+qzSKAKSE4
 6iSJtx4iFdDCmW5FKOMPBfTHFj3rCxyBrTV+CYj8DOd+cjXW32ObGgsys8Bd/c/JBc/oS5urJGX
 FxLa1h009VDiiDeeyvnVShaUuHSPKFF+AwmlI7CAySAM1cpv2lHMFHXyjcRPmfmM3/M57Galz5V
 21BLC8+PVbqjiMW9hrF9CGZV72rc1IYGF3h6hEviYX49C1MH1FY3LDjM0xpP0oPXmT8aaP6MCmM
 FyUl2Ak0GG0nDZSwvOiqu2/cgGO7xCGlslpka+adf2ZuKPlj4dOUwvyR5G3nPXTCj8naxCuFyd3
 +DJmJydoiojXrAJglHAJNEfVyNI5XbxmihELjXm+Goto67kMwOfAudVZ9l1TZIMbyTfiNaTUTgU
 md+SA3v6wT0nKJ4WvEw==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a5661a5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=sZWLkp-kluRfRaLivIQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: o6GXcxiznXeGfwKjRNkQDO3HMRNZOAVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140168

Am 13.07.26 um 20:14 schrieb Christian Borntraeger:

I just realized I had my kernel.org address in from.
question is, is this the right fix and shall I do a proper patch wit correct from and signoff.

[..]

> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 8f10762e90ef..a811e431b47a 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -32,6 +32,7 @@
>   #include <linux/err.h>
>   #include <linux/kernel.h>
>   #include <linux/slab.h>
> +#include <net/af_unix.h>
>   #include <net/sock.h>
>   #include <linux/net.h>
>   #include <linux/kthread.h>
> @@ -1241,6 +1242,7 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   static struct lock_class_key nbd_key[3];
>   static struct lock_class_key nbd_slock_key[3];
> +static struct lock_class_key nbd_unix_iolock_key;
>   
>   static void nbd_reclassify_socket(struct socket *sock)
>   {
> @@ -1267,6 +1269,17 @@ static void nbd_reclassify_socket(struct socket *sock)
>   					      &nbd_slock_key[2],
>   					      "sk_lock-AF_UNIX-NBD",
>   					      &nbd_key[2]);
> +		/*
> +		 * The AF_UNIX stream recvmsg/sendmsg paths serialize on
> +		 * u->iolock, not sk_lock, so it must be reclassified as
> +		 * well.  A held mutex cannot be reclassified; skip it in
> +		 * that case, as sock_allow_reclassification() does for
> +		 * sk_lock.
> +		 */
> +		if (!mutex_is_locked(&unix_sk(sk)->iolock))
> +			lockdep_set_class_and_name(&unix_sk(sk)->iolock,
> +						   &nbd_unix_iolock_key,
> +						   "&u->iolock-NBD");
>   		break;
>   	}
>   }
