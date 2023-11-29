Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fr2h/lp3"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1782AF
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 04:54:25 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATCqAad004815;
	Wed, 29 Nov 2023 12:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=m6futr9fpBaphSfrMKTs7g+YqH+aeZ+D5alkCw7+gQY=;
 b=fr2h/lp3+qm4OCsNDmZ7cOAAGrWdUYkDHnFnGoOyZCrN3t+3SL38GPf550rq4p3xvvi0
 fo2E+0neSIcv9qgP6IpJCy2I+jW/11q0iUr/TqeglGhNmu/JUXtHTX3ecEi1L1vh5SGz
 6fme5XzgO7rirSIXmU94NCSSSFYGRNFfs6gSSSFTzdDvBrCjODkAKbYnlR0MYfy6m6PJ
 MInrxjBqOS44MJ8DBXDj9TFjZ+R5LNq1Q6qEhuiHmUD/CREdqIxLI5UVSgBhRFuDPavd
 nkKSlh3VdGpMmvEEWcKEwdrIptjtdTDd7o/eucRY2alwlGeHc7V4Hjl+S40r/6TodM6e KQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up5pbg2h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 12:54:22 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATB48FV018092;
	Wed, 29 Nov 2023 12:54:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8nq7s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 12:54:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATCsJBp17695348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 12:54:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78D252004B;
	Wed, 29 Nov 2023 12:54:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D431F20043;
	Wed, 29 Nov 2023 12:54:18 +0000 (GMT)
Received: from [9.109.253.209] (unknown [9.109.253.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Nov 2023 12:54:18 +0000 (GMT)
Message-ID: <a31aa0a8-06b5-42a9-8306-7dadee5c5fcb@linux.ibm.com>
Date: Wed, 29 Nov 2023 18:24:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] loop/009: require --option of udevadm control
 command
Content-Language: en-GB
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Alyssa Ross <hi@alyssa.is>
References: <20231129113616.663934-1-shinichiro.kawasaki@wdc.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20231129113616.663934-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eHuNeoBnTZ6S3wRKPXerMX9oRwVmt43X
X-Proofpoint-ORIG-GUID: eHuNeoBnTZ6S3wRKPXerMX9oRwVmt43X
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290097

On 29/11/23 5:06 pm, Shin'ichiro Kawasaki wrote:

> The test case loop/009 calls udevadm control command with --ping option.
> When systemd version is prior to 241, udevadm control command does not
> support the option, and the test case fails. Check availability of the
> option to avoid the failure.
>
> Link: https://github.com/osandov/blktests/issues/129
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks for the fix patch. I have tested on Power10 machine, loop/009 test skips with patch applied.

# ./check loop/009
loop/009 (check that LOOP_CONFIGURE sends uevents for partitions) [not run]
runtime  0.481s  ...
udevadm control does not support --ping option


Feel free to add:
Reported-by and Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/loop/009 | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/tests/loop/009 b/tests/loop/009
> index 2b7a042..5c14758 100755
> --- a/tests/loop/009
> +++ b/tests/loop/009
> @@ -10,6 +10,12 @@ DESCRIPTION="check that LOOP_CONFIGURE sends uevents for partitions"
>   
>   QUICK=1
>   
> +requires() {
> +	if ! udevadm control --ping > /dev/null 2>&1; then
> +		SKIP_REASONS+=("udevadm control does not support --ping option")
> +	fi
> +}
> +
>   test() {
>   	echo "Running ${TEST_NAME}"
>   
