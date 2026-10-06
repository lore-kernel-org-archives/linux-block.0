Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842A33E7630
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330818; cv=none; b=pHKkXwEAKcAIZ8z1OUQugW7Z0R8cQVdAHK63jLp8z4RKv5NJhryiSiYBX65dvwJzz7+lwQ8pAe8rXYEo541hTq+TeN0PxIC0hZuSZNY3BwuZ6bi2eO0C74m0O2WbN5mTer3QF5CjPbuMEFYNgRt4q7LV27Jjxd1A4GVe3BLHKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330818; c=relaxed/simple;
	bh=xf167AZzu0nvnTcAX1Xw8R4tyYv+cUzmt2UzRs7bslQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imh5BvVqMqAiyPy6GhtAyteTRL/AFMK724QKMeZ+LaIQmQbZQguO10WXtDOjVW21aDKO1VTmbjOqaCNuPF/fJrwGGZLSxI6Fv2SNL/YwQGlhksIQd13dN7hFIZ/89F28LiLH3UHbj+qmunixmonnSg1XarD3tNlSCcQKw7Teh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KkiWrAzX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P+z66KUC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KkiWrAzX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P+z66KUC"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696LeNOt1899645
	for <linux-block@vger.kernel.org>; Tue, 6 Oct 2026 23:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IFp8HdaEfTURv3yOkfDgaxZg9EFYUbB/frsyn4UIA0o=; b=KkiWrAzXJ0cWLYsj
	DWrvvW6RLnt3U7oadPNWuvLNs4UbwqMb8BQRas/iqGSO8pxrAF8kzD78d5B/Ltuk
	oL8+9fqfkFcty1hY9Sg3iWS91ESxCx0tej2TAhoUoFuc3sHOIIl8aQ1MheovAUDh
	Ax+ArVACEAlkOwleqh9YCYjDEMAJVoRkh055+d1JSzoE82U6W5dLfau66blM+hDn
	mvaOsS6YbEjCM7ZzId1oG2s4lfaaKPqi2I8pRFwKPcnzGrBTYgNCoa1dj3G5yCow
	XcDAkZGhMgqdjV5tWVaZdkm10tuBqqhsJ6tOMhtTQB1mtx9eIq2a4CBou4P8WPmT
	ErMHKg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h541uhub8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 23:53:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510562ef98so4602372eec.0
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791330815; x=1791935615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFp8HdaEfTURv3yOkfDgaxZg9EFYUbB/frsyn4UIA0o=;
        b=P+z66KUCVaVdG46mJGBGEu5X1yP6CIlTB8KEhhLufX14Vq7SkRLBU2EDXVLBwUYMq8
         DT4ZlSb+O0gjvnQuJVTqr4elpS7JLns8f4erz8+90Pt3qshRCZyJLYBRU2bhj+B4lQJ+
         kAZc/fpIDQkNysIfNDXB+pYt0JQs4ucgyzROgdPkkW3S6NHMxQv/rwtmYntJsmtUj5a6
         FmgcIw0sABG9S5SPYl+cmyobYtVz7Pbq5hLlFfDtK9ZsOSTG58/mC5yJxwMNOGrVH+P8
         gFfRH+iLRUOKmVScQAd5L95o8iuYnbK17LE/7JW+krkqqovmURmRWD6ZVrr49YEvuGtz
         Mz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791330815; x=1791935615;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFp8HdaEfTURv3yOkfDgaxZg9EFYUbB/frsyn4UIA0o=;
        b=2Yo6WQWweJyVpHZdoKjdY9Bf5BouJg5Gl4z3ySXReuxKZi7Uw8FYAfs8Xb/dGVje7j
         M5P/j55RbGkwyMOL3Cl+DWE9IilS4/aFCBhnJp81fgnUZ/P020l5WyjuwtG3hlPxlFWY
         UppiBvUzvCqw3u+f/9TDUpzMlZG3YTdSZ1hzj8daJmfOFUwjxyGtJh7q+jqQgJ5QLhsD
         ncZxmMs3ojs28xZKP45HX6W32Vxu2BG98NcapKZioH9Z073GE8tWAHnx4Ojbyj6NW0U9
         B1+iEhc/y/jTVc4Iw1eQ1umZ2J0VVQAyZ6hSA7a0n49COEWhXLEnusiKiZ3huljFsjkL
         Y9ng==
X-Forwarded-Encrypted: i=1; AKwUvBysvA0dMLR3Xat8VHv2ulStX5Tvt8RRlAJ+Hqow8Od2o+QTkeX/cYeYREXMSyeLiDbeh1cKAwFiD2YDHA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIlE/bnU4kTFsb1e6ySK5sbBbjj4aTAv+teQhdF9awhbK/7BRbR
	ei7m8N8MMmPAyZ2yoWqPcMCshXAxz9oHjWQhsV8t6mRhNF1mzGr7s4wt5KKDZ4UBSMkLku5lFsD
	awGjdwjMwJaZMRB4F0s84/iFP98JbBY8BxCVqlD8FeZUyhycJMM5iEYdznzw50/tyKg==
X-Gm-Gg: AYBFou0cPSIYCODF80ehABgeVx1Rz5LNpvZOJOkqrU1vVAtF1U0VttnQjGAnh6yPhvZ
	ek+V9kgUUMOcr2ATmulr0L+2JDM9a4vImtW0xE15UPx9qvif2RyoF6/n6r/9T+2UxWjw9MZonzW
	nxhr8D3bPtDsf3QQG4oFJaRFZsEp67o/xAOqzVzUU38lG8pPRtk8Op9TglSdqGs/gTX0mDS56QN
	HchnXaGT2qRUrLJkrucRmDx/AokrskJQt9Ghfy4b2QXmcfW2jFaxSA9qp4we+xJ7RoN/cTmMTVN
	7XSjGXCvZczzafLY+fMWzbRU+d9RweeqZ7GHQ3err6cjhGsxvL4lY2AevTWj8MhQoSiB3g3xr/0
	jPmBiph5lsTiyWb2xaEwFA9/8MLdnWmiGVZ64btzr0b8Zx8iWN8qJ9L7qxiVnOV0=
X-Received: by 2002:a05:7300:e5cb:b0:34b:f456:25ce with SMTP id 5a478bee46e88-3515d86f096mr371884eec.3.1791330815338;
        Tue, 06 Oct 2026 16:53:35 -0700 (PDT)
X-Received: by 2002:a05:7300:e5cb:b0:34b:f456:25ce with SMTP id 5a478bee46e88-3515d86f096mr371852eec.3.1791330814702;
        Tue, 06 Oct 2026 16:53:34 -0700 (PDT)
Received: from [10.71.184.34] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515afa61e8sm1972503eec.22.2026.10.06.16.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:53:34 -0700 (PDT)
Message-ID: <4ed3f09f-74fc-4f07-8897-5c773fbde0b2@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 16:53:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, axboe@kernel.dk, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <ar3yt8Kl3WUV93lP@google.com>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <ar3yt8Kl3WUV93lP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1G2UAHfNjCNTX5A7r5lkthSBJj8oj11I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX7R6i+Yi9nXcd
 YjWD7oblpqVsaXdLJ8rarJlvGpLwN2R6xoaWMw7labe/EH4mCZR9GDKJwx6jmjYV30vui2K/MA7
 mHPMc8+WNfmVhfe0BX002t2TRORlN98=
X-Authority-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6ac58a00 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=9kMCAbyDuj7LhItxiaIA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfXxuz6ultS7e0M
 yNnunjSvEjjfsdwQ23APQwFCQNVwN+UiliahmDN4zn/WqIQQWcMbLRrh9XdB5+dGETYj8HkG2uo
 cTPaHwB3k3b4fl3xZkFMeOdkLrTq341q2hiyYjDqZxuR6TbNbJ0YXSo/H8O9VOfo2EODdi5wrRc
 9C+IeloJZqOJr4c4p06JXH/N7pUiZr0XD5RF6I7KvF3pQOot/3TVX1EBxuEC1hMMyxp6dvDLVq7
 boutJRTfD7cW9ZxkiTfHAmyDqvil9vwQhnP+aoCscPHQUkBb52CFCIkkMMrxkdeG19GBHwUGJa6
 85dHL+UhPl6aV5WCZyh19biDXBNXOauPoUPkMOpluLyX+7VXH2uJt6+JKs2G8IKOeVw0LMLa09M
 ju5zbClhkXeo+8RNu5PVLJtPJMHCL7S1/xFwPL9zKnGaVJXQNyOD4Cr+j2aDLP4zcAi9N8Z/uF0
 SGJjO1svEVm+N0VC19g==
X-Proofpoint-ORIG-GUID: 1G2UAHfNjCNTX5A7r5lkthSBJj8oj11I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060095

On 9/30/2026 10:43 PM, Sergey Senozhatsky wrote:
> On (26/09/30 07:52), Georgi Djakov wrote:
> [..]
>> @@ -80,10 +87,10 @@ static const struct zcomp_ops *lookup_backend_ops(const char *comp)
>>   
>>   	while (backends[i]) {
>>   		if (sysfs_streq(comp, backends[i]->name))
>> -			break;
>> +			return backends[i];
>>   		i++;
>>   	}
>> -	return backends[i];
>> +	return NULL;
>>   }
> 
> This hunk looks unrelated to the patch in question.
ACK. Will remove this.

Thanks,
Oreoluwa
