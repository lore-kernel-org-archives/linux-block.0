Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC23195FC
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760877; cv=none; b=MbyLpluY2QK5mr3C4Y2QpX4YKVNz/ApLcvzzyTmOxPGcm+bDO/lPoOxY9Whj5Uvf+7M65Momv02M0IXbsqQX/97cyzPdwK9gMgUuXDGwC4DISVT7oneg97c3fAlOG3gDnaERdH3ihwx7kGOlasG4bI0s+grZnNmAf8vdTLhSclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760877; c=relaxed/simple;
	bh=HITamePOFQ6xKFSAF+Mlb/PmV4vIExJ/NInzdHCOzjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpr+G43Kd98f1jMNPXcY5HAFVvvC2nDa9PoPZGaAnocNEIRGRoG0qx0+WEpywfGH9Objd6wx28dne+HFCIrK8eRx9GV3gO8twKh+5ugN2W5Fq5Xvuppi3UCktg3EqrZf+AbEFLDYmHlDCI8mGq86+KWXhFVDQGA8aCJ3TBUKRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZAtJSsKj; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZAtJSsKj"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639Ig4Se1089945
	for <linux-block@vger.kernel.org>; Thu, 9 Apr 2026 14:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=sw6G
	wRk7Qp2WRM++iKaHx+hBQAaMKviN9vTfKu8ETKo=; b=ZAtJSsKjbJ+Hx52hia8V
	5BMqLKGKSsStdVWtGKARsi0D128R4JPKsI86AourUUAoTURwWTj35qcQxipX3bWP
	a6q3sdKorNc6YRrCwTJb/TCMxv3p+mxXbU/gTz0zRx16uUBEfpyeh9ojfIrrl1aq
	v46cmPYqZ9ZsuXvF5ZJpb2hQ0JPDNtX0YlfISoHeTAQyYnZZ09MubrDOhccs0Z3H
	/91KAb3XVWlenwMNgfnasO8BAjtbph26AK473sh5c15lh7ocLkyw8qQDtKZiOtI3
	kyLlhC3ioSigG1ElxYY76Q5lLYGJj27fPkR12FO/wB9Z+gml0Y8wUuiIjTb8Ele2
	7g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dee5f27wc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 14:54:29 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89ebd9e1ee4so23976366d6.1
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 11:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760869; x=1776365669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw6GwRk7Qp2WRM++iKaHx+hBQAaMKviN9vTfKu8ETKo=;
        b=qJIazZ9uQgXrVvKyKVvZHPBsURbeyJOGzPjwIxb2/ImEyiv1dE7KpPvFUlbpLfsRl9
         gRO6GBf2L4bjquepJI4LpJ2kAOCLXe12IoN8OVFrU3vAcWOei0q51Sfk2rVWJVIUFkRN
         SIG+lWkGehlUdzPCnDcPTekAugT323v+UfANQlhaFCOjDFlnZmEp1wxA1uRiiNy0oF+f
         dUQcYXo0+ORIrU9YZeHqwuIfEs+nXwGhqTJlNfhFnJonkyaVAUY9JdWfpwhCYDmd5koI
         LsUrup4iDl8Ntq02T4qSk0l2cr3Dus80jR9xD/ch/90wKm8WFt4REa737Qx6FIlGMMNo
         nINw==
X-Forwarded-Encrypted: i=1; AJvYcCWktDxx5+VhvPf4zVddKt8q43bkYaKZTgOzMP6JbtzHwxOqZk15Dhs5+lMTlU+Q4QAzhZqrRwths6CBGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoJxrSSlhRQda3Yw0sr51NG+42quVGXCUc6Yz2UwSkR+9nZIh
	lpAAS35e1czMz3Y9EAwRymto+tuanRf1qnuoCr6FQzyGorzUGVXZ6b91cnYmJWq+iH1dGIFtepO
	lxNEgvjob8AbnQAYTzjez8eC9AtpItAeRxQN9iAwYA7XoYZ0tMBGXq9oX/jpb
X-Gm-Gg: AeBDievrb3dQa3znWDI12gQWeJKoe4XOkkXDG8LUap6PNqwPz1PGjfIH1XJssBu6PBT
	ytdmgANDqQGdVJTpIiz3j9Yti2qaezF+NTelOCjGYne2SpKxlHBtvHHjrn8VUV9DYGGkAujABWq
	XC2wBGVcRE2waBpxUfuFhK9gT637bjS4RGBnOiKrKbTKJ0pUPo517+3Dyt5JU3kXIj/pPu1sr9T
	b4g1Kd4QSOyE2fDQjB1EgwRHJU+8yYNhW1tJ7Ian51tWHEyYuhWizaKyZOc7sZkkTIw+kW9rMH1
	ECfj80zYAwiQnAmEm45iqVc2h49hjykLjKNBihYtg3VvrMZd5h9ZJzxprOTm1HzwJ38y6lm2xNS
	UhP4Z+jSHX0J45RbpNhHak7VvLKLXLxxYUbLyjUiU
X-Received: by 2002:a0c:f114:0:b0:8a3:221d:9095 with SMTP id 6a1803df08f44-8ac743038b7mr72761196d6.15.1775760868934;
        Thu, 09 Apr 2026 11:54:28 -0700 (PDT)
X-Received: by 2002:a0c:f114:0:b0:8a3:221d:9095 with SMTP id 6a1803df08f44-8ac743038b7mr72760866d6.15.1775760868507;
        Thu, 09 Apr 2026 11:54:28 -0700 (PDT)
Received: from [10.206.71.59] ([129.236.231.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849db4b8sm3093516d6.7.2026.04.09.11.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:54:27 -0700 (PDT)
Message-ID: <7e468bd2-e52b-4165-95c6-3f04e1dca21e@columbia.edu>
Date: Thu, 9 Apr 2026 14:54:27 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] block: add BIO_COMPLETE_IN_TASK for
 task-context completion
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <97b81868-6410-4c79-a242-679a9f04f073@columbia.edu>
 <95F28FA1-5CEF-4E80-BBB7-A429B4437D12@kernel.dk>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <95F28FA1-5CEF-4E80-BBB7-A429B4437D12@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PdLPQChd c=1 sm=1 tr=0 ts=69d7f5e5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=RFpAoTwO7tzpE9r8PTiuXw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=y2ETOFklOQM5vU7YwEUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: _cBVnJCMFxR-l-6csYArd3bSsiS85Ra2
X-Proofpoint-ORIG-GUID: _cBVnJCMFxR-l-6csYArd3bSsiS85Ra2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MyBTYWx0ZWRfX5s21kDKF7g95
 WZ1SgaEiwzH3ZqN2AJndr4t3F4YEWWEx2H7qqgtZa0gTwf1Gh1q1ry8sn/EB6b2Oe4C9WXAavtE
 HfIPW/PR5RvBqT54y9elvV1iodPlTZa/rlPqXsvREyIbFrQOqMNcwY7IxrUAdTNQmIfSuVDGInM
 o8JJE05b6nWc/eXxgQFN8JPfeomgtqXMwaaZYoVtqKQSFbe/kIj5M4VhtqygcR8v7v5sMkGRFBR
 DQyMSRVgtT5dTmJvJQEIX36TeZO3tTYdNyoMzq1iAhAq13r1Nl8jKdCLYeg5kf0OGKGLroYskTj
 dP3/++bZ8x61jKFhwquo6eKc/oc6gDvXrfyX9nuVmHS6T0eLPYIC/bNjD38uj4c3tfFkNZygiws
 3ZV6d8Er5/H7LdJ3V7At9XlJV34hRGN7U8yOlZzbc50kDi8AYuGiY3QGmPYm932r0LmXr+Qh9FJ
 97PtUVMfl245/gO09Zw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11754
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=10
 lowpriorityscore=10 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090173



On 4/8/26 7:36 PM, Jens Axboe wrote:
> On Apr 8, 2026, at 4:51 PM, Tal Zussman <tz2294@columbia.edu> wrote:
>>> On 4/8/26 3:51 PM, Jens Axboe wrote:
>>>> On 4/8/26 12: 48 PM, Tal Zussman wrote: > On 3/25/26 4: 14 PM, Jens Axboe wrote:
>>>> 
>>>> Thanks! I'm going to give Dave's llist suggestion a shot on top of
>>>> this as it seems like it'll simplify this nicely. Looks like that'll
>>>> involve turning bio::bi_next into a union with a struct llist_node.
>>> 
>>> Since these lists can get long, I'd keep an eye on llist reversal
>>> overhead there...
>>> 
>> 
>> Going to send v5 shortly -- tested with and without the llist reversal and
>> it didn't seem to make much of a difference. This was on a single-disk VM
>> though, so any stress testing you could do would be very helpful.
>> 
> 
> With all due respect, a single test like that isn’t going to be that useful. I’d be wary of making that change willy nilly and just thinking “it’s fine, worked fine on the one case I tested”.

Understood -- unfortunately that's what I have access to at the moment. I
can requisition a machine with 2, maybe 3 disks, and test more thoroughly on
that before sending the next version, but that'll take a few days. You had
previously offered to test on your big box, so was hoping that was still on
the table :)
(Although Christoph seems to have proposed moving away from llist again)

> —
> Jens Axboe
> 

