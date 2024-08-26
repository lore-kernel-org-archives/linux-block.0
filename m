Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B07404B
	for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650691; cv=none; b=kr2W7nSVPgw4YnOz5ruUaac0St7uqdrqUjgEj1xEGWAzYHSq1cixAJcMat3RmLbvqy5I/NnrrUSLWedda7ogA1yMqT3jV6mPr7lgWZidDnAAh5l4prjy8L8FZF4jSvVYVKaBYO6TTVjMtb9Y+xbgcicDOVBoG77W6WPzqR5ki3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650691; c=relaxed/simple;
	bh=0PlHExSZ5nqdcqTH47Y8m0mwWWq6Dnsdbg4P71ONug8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLolJ4AYEE9jCMi651zh6ztTsZMjlXdUEhECeY+tk05aXntHOAeQfBLSuECOf8/rouU6Brqrc4beZ9mKeHcU4yO4ptWVDuiUQLIMux3PkO0E8alkPIrcPvPFm0fGAQnRNZNery9YDoyOm6T2DhNain7sMnu2r9r4q3sJvQql+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z/17Y1zA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z/17Y1zA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q1dwTl016372;
	Mon, 26 Aug 2024 05:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=T
	54Wsk777Xf2haqY7FfYY/vjVxpBNUfJDXngv7zp/k4=; b=Z/17Y1zAT6eChEQa1
	AratEC72ywUce37acz12OylG05ixpa5oUDKKGg6voiOQ8EJlJIYRQcB82C7rtnK1
	KbQwtrxwPfr/RrLH7PTG5PexfBfMaJindrTQZmMved+KWrAlLlYn1Wlu1fyi5HXD
	yn8H1Ct400DTLVDoIB531HWeEXEHSPsRT2caqMq3VyZa3mLtpRNyLSJ9HaAx1YvL
	+J4pk0YM0gohPALH0XXZJYXHOjVOxVSiCFLS2azyKCd0+KSZJzZtxw5S4IP7OQgm
	5wrw+okTikwpNRqLKu1OScrxkjmw9SEQTxIg63j6JkJp+Lxmw8EwYR3ShCYnkDi2
	PZ2TA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417ged538u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 05:37:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q4psAr028010;
	Mon, 26 Aug 2024 05:37:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417ubmvgxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 05:37:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47Q5buAa28246560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 05:37:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E11CC58062;
	Mon, 26 Aug 2024 05:37:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 596BF58057;
	Mon, 26 Aug 2024 05:37:53 +0000 (GMT)
Received: from [9.109.198.144] (unknown [9.109.198.144])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Aug 2024 05:37:53 +0000 (GMT)
Message-ID: <2a550653-89b4-4c3c-840a-a905152adb5f@linux.ibm.com>
Date: Mon, 26 Aug 2024 11:07:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme: add test for controller rescan under I/O
 load
To: Martin Wilck <martin.wilck@suse.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
References: <20240823200822.129867-1-mwilck@suse.com>
 <20240823200822.129867-3-mwilck@suse.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240823200822.129867-3-mwilck@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4D0Tawf7huLmRhvFxrl2TSznisSaeXYe
X-Proofpoint-GUID: 4D0Tawf7huLmRhvFxrl2TSznisSaeXYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_02,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408260043



On 8/24/24 01:38, Martin Wilck wrote:
> Add a test that repeatedly rescans nvme controllers while doing IO
> on an nvme namespace connected to these controllers. The purpose
> of the test is to make sure that no I/O errors or data corruption
> occurs because of the rescan operations. The test uses sub-second
> sleeps, which can't be easily accomplished in bash because of
> missing floating-point arithmetic (and because usleep(1) isn't
> portable). Therefore an awk program is used to trigger the
> device rescans.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
> v2: - don't use usleep (Nilay Shroff). Use an awk program to do floating
>       point arithmetic and achieve more accurate sub-second sleep times.
>     - add 053.out (Nilay Shroff).
> ---
>  tests/nvme/053     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/053.out |  2 ++
>  tests/nvme/rc      | 18 ++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100755 tests/nvme/053
>  create mode 100644 tests/nvme/053.out
> 
> diff --git a/tests/nvme/053 b/tests/nvme/053
> new file mode 100755
> index 0000000..d32484c
> --- /dev/null
> +++ b/tests/nvme/053
> @@ -0,0 +1,70 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Martin Wilck, SUSE LLC
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="test controller rescan under I/O load"
> +TIMED=1
> +: "${TIMEOUT:=60}"
> +
> +rescan_controller() {
> +	local path
> +	path="$1/rescan_controller"
> +
> +	[[ -f "$path" ]] || {
> +		echo "cannot rescan $1"
> +		return 1
> +	}
> +
> +	awk -f "$TMPDIR/rescan.awk" \
> +	    -v path="$path" -v timeout="$TIMEOUT" -v seed="$2" &
> +}
> +
> +create_rescan_script() {
> +	cat >"$TMPDIR/rescan.awk" <<EOF
> +@load "time"
> +
> +BEGIN {
> +    srand(seed);
> +    finish = gettimeofday() + strtonum(timeout);
> +    while (gettimeofday() < finish) {
> +	sleep(0.1 + 5 * rand());
> +	printf("1\n") > path;
> +	close(path);
> +    }
> +}
> +EOF
> +}
The "rand()" function in 'awk' returns a floating point value between
0 and 1 (i.e. [0, 1]). So it's possible to have sleep for some cases go
upto ~5.1 seconds. So if the intention is to sleep between 0.1 and 5 
seconds precisely then we may want to use,
 
sleep(0.1 + 4.9 * rand());

However this is not a major problem and we may ignore. 
Otherwise, code looks good to me.
    
Reviewed-by: Nilay Shroff (nilay@linux.ibm.com)


