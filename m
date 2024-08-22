Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0211A707A
	for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325359; cv=none; b=uls08jlJnYeRWOHTvY8SbRl+SWbf1ybOK3QIhnO3eLyWoyNdcu58gvt8yJQJDbkGAhl1thU3W4YbGAPOCdXk74IrqSaidaQ/URiw5Oa3vz2i0+4lUtQpayNnS1jQd2Q+bxRgJal17YkkQHiErBKsj7oUmaR/FQg/BnlrCGtwJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325359; c=relaxed/simple;
	bh=ZYM/U2O8x+GgMGrwq8ceCSN6ZEWliYschteyNCfj4jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaArWKvRKqBa5+jWSrGp5IZmNPEN+i6ZYGvF5KOwz/3TXMYEU3qBJiMaGQmnzrzEGed4nX8ERNFU0kd8NL3ZN2vELtG8oKJnIkI8SCTpFn+L7nDkTVwTDuhWVZ79MuYnabxPIfwZV4WRx304CkDnK18/Uk1qCL2Wf2U6KUsyVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uzshwr25; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uzshwr25"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M4PLCi005305;
	Thu, 22 Aug 2024 11:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=y
	2B0MKWVgqAHB42qCsf7Ka184IBfH0Mbjky+nasUmK0=; b=Uzshwr25FUuFBSJZx
	4gR9AyL54o52Uz3YJLUUdj8Dtd0WMiVb3TvTK3SGPsJMBc5Vhj33sTjExsOhq0mo
	lIU/Z59Tu/YcoMy6M2S/mQU7XI1GxgDavxlj6W+Mu8u1nTQBCWHMmKiRldxOxVHg
	2+5piANbLgsmjEcyOHNpb2GzPxnd8NVxpaublap6jKUHNwwjcQnNwWBI4OUH+TY4
	l1xXR1NOOGMUwVlLA6Iw/omnigrPfWblRO7CKI9quhxFtp/sjrVdTviTETdp+7yk
	ks96TgWeSRynutNmYcBGh0qZI66RfVFhmg7L8ke4TduG1ZOAARy9wA5IFH6bNvBv
	zy9Lg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5yj6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:15:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47MBCAWY028726;
	Thu, 22 Aug 2024 11:15:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5yj6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:15:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47M829gg017666;
	Thu, 22 Aug 2024 11:15:50 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w3c399-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:15:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47MBFldf27132460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 11:15:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FDE758057;
	Thu, 22 Aug 2024 11:15:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC30E58059;
	Thu, 22 Aug 2024 11:15:45 +0000 (GMT)
Received: from [9.109.198.144] (unknown [9.109.198.144])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Aug 2024 11:15:45 +0000 (GMT)
Message-ID: <12fa9b5b-8a8b-42a6-9430-94661bfbdd21@linux.ibm.com>
Date: Thu, 22 Aug 2024 16:45:44 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
 <d22e0c6f-0451-4299-970f-602458b6556d@linux.ibm.com>
 <zzodkioqxp6dcskfv6p5grncnvjdmakof3wemjemnralqhes4e@edr2n343oy62>
 <0750187c-24ad-4073-9ba1-d47b0ee95062@linux.ibm.com>
 <wf32ec6ug34nxuqjxrls5uaxkvhtsdi4yp2obf5rbxfviwlqzt@7joov5mngfed>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <wf32ec6ug34nxuqjxrls5uaxkvhtsdi4yp2obf5rbxfviwlqzt@7joov5mngfed>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xZ9I22Gjt-wR_yIc_tO4AT0mQdiM1znM
X-Proofpoint-GUID: Z-qEH-vfAGiFDuY2eevxzp9gh-fjlVhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_03,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408220082



On 8/22/24 14:03, Shinichiro Kawasaki wrote:
> On Aug 21, 2024 / 14:58, Nilay Shroff wrote:
>>
>>
>> On 8/21/24 12:51, Shinichiro Kawasaki wrote:
> [...]
>>> diff --git a/tests/nvme/052 b/tests/nvme/052
>>> index cf6061a..22e0bf5 100755
>>> --- a/tests/nvme/052
>>> +++ b/tests/nvme/052
>>> @@ -20,23 +20,35 @@ set_conditions() {
>>>  	_set_nvme_trtype "$@"
>>>  }
>>>  
>>> +find_nvme_ns() {
>>> +	if [[ "$2" == removed ]]; then
>>> +		_find_nvme_ns "$1" 2> /dev/null
>>> +	else
>>> +		_find_nvme_ns "$1"
>>> +	fi
>>> +}
>>> +
>>> +# Wait for the namespace with specified uuid to fulfill the specified condtion,
>>> +# "created" or "removed".
>>>  nvmf_wait_for_ns() {
>>>  	local ns
>>>  	local timeout="5"
>>>  	local uuid="$1"
>>> +	local condition="$2"
>>>  
>>> -	ns=$(_find_nvme_ns "${uuid}")
>>> +	ns=$(find_nvme_ns "${uuid}" "${condition}")
>>>  
>>>  	start_time=$(date +%s)
>>> -	while [[ -z "$ns" ]]; do
>>> +	while [[ -z "$ns" && "$condition" == created  ]] ||
>>> +		      [[ -n "$ns" && "$condition" == removed ]]; do
>>>  		sleep 1
>>>  		end_time=$(date +%s)
>>>  		if (( end_time - start_time > timeout )); then
>>>  			echo "namespace with uuid \"${uuid}\" not " \
>>> -				"found within ${timeout} seconds"
>>> +				"${condition} within ${timeout} seconds"
>>>  			return 1
>>>  		fi
>>> -		ns=$(_find_nvme_ns "${uuid}")
>>> +		ns=$(find_nvme_ns "${uuid}" "${condition}")
>>>  	done
>>>  
>>>  	return 0
>>> @@ -63,7 +75,7 @@ test() {
>>>  		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
>>>  
>>>  		# wait until async request is processed and ns is created
>>> -		nvmf_wait_for_ns "${uuid}"
>>> +		nvmf_wait_for_ns "${uuid}" created
>>>  		if [ $? -eq 1 ]; then
>>>  			echo "FAIL"
>>>  			rm "$(_nvme_def_file_path).$i"
>>> @@ -71,6 +83,10 @@ test() {
>>>  		fi
>>>  
>>>  		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
>>> +
>>> +		# wait until async request is processed and ns is removed
>>> +		nvmf_wait_for_ns "${uuid}" removed
>>> +
>> As nvme_wait_for_ns() returns either 0 (success) or 1 (failure), I think we 
>> should check the return status of nvme_wait_for_ns() here and bail out in case 
>> it returns failure same as what we do above while creating namespace.
> 
> Agreed, I will add the check to v2.
> 
>>
>> Another point: I think, we may always suppress error from _find_nvme_ns() irrespective
>> of it's being called while "creating" or "removing" the namespace assuming we always 
>> check the return status of nvme_wait_for_ns() in the main loop. So ideally we shall 
>> invoke _find_nvme_ns() from nvme_wait_for_ns() as below:
>>
>> ns=$(_find_nvme_ns "${uuid}" 2>/dev/null)
> 
> It doesn't sound correct to suppress the _find_nvme_ns errors always. We found
> the issue since _find_nvme_ns reported the error at after _create_nvmet_ns()
> call. If we suppress it, I can not be confident that this fix avoids the error.
>
Agreed, however my thought was that if we always(while creating as well as deleting namespace) 
validate the return value from nvme_wait_for_ns() in the main loop then we should be OK and 
we may not need to worry about any error generated from the _find_nvme_ns(). The return 
status from nvme_wait_for_ns() is good enough for main loop to proceed further or bail out.
Having said that, it's debatable as what you pointed out is also valid. The only thing which 
looks odd to me is that we have to suppress the error from _find_nvme_ns() for one case but 
not for the other.  
>>
>> On a cosmetic note: Maybe we can use readonly constants to make "created" and "removed"
>> parameters looks more elegant/readable. 
>>
>> # Define constants
>> readonly NS_ADD="added"
>> readonly NS_DEL="deleted" 
>>  
>> Now we may reuse above constants instead of "created" and "removed". You may rename 
>> constant name if you don't like the name I used above :)
> 
> This sounds too much for me. "created" and "removed" are constant strings, so
> I'm not sure about the merit of introducing the constant variables. Number of
> characters will not change much either.
> 
Alright! Maybe this is more of a personal test.. so I am fine either way.

Thanks,
--Nilay

