Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7B320CCC
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198583; cv=none; b=uKpInCZ2pC/QioMLUYqdCsj4kH+f+lCcHWYID1kj3kzxLe84AhQG2xrrX/l0cFS7x5W5WnQFZs5/TvFpvXM3J2+1AFRO876b3gBDq51Yz1QEQh4hDVN8Po4cFaVAjcYA90rP80DUcr8TCBT6AN3MeX3dB/Ktoq5qGWMggTj1Eow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198583; c=relaxed/simple;
	bh=yQFz8DM3su/UkwgPRuXCLRbPCiZ8ugq/3jme6jahFPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phBUD4fdcFenw0Riyd3jTN3RDm8OYGzJv//cPesP2IWQ2QhYLPahY2rABMkahaghvNltnf6ETvDUYROXiROcAB2RIKqJbM9XitJxeSSrmC+BACBiTvWEeYlo1Qa6ct6ai2LShbh2vADunorT66npE5umNpaXDNRO7z3llUU6hqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=k22q0YhV; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="k22q0YhV"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EKR6hu2500945
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 16:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=WXFq
	nVJ4T9hxAVeyiDV1ooSXjwN82kyD0WFAZyEIayY=; b=k22q0YhVQZiPT7EsK4qY
	kXKKf20d6Eyoq5zv/bCMosbe1p6ZTAAFqGYN1jql5TMO79N5C7HaZt6Z/cwriJjh
	i908rxBG1P3Tp2CF3EvYaZY5/Hh5bH5gz+cbWycowOy/ULW12oZEyg7fnlzlbtCW
	g1tmittXLgbbnNnyoVTcES5p2xk8gc68UqDO+MLS2VTyn0RAe4ulKHNSip2O7W0f
	wus22rwT2+tQnLCpj7WtrZzSZq7OwUEon5xcKGVHybeez2whx+pca7FQyi3SR4Su
	EhEEbwNysh4gXoSo/YVDtxTkm4zxUm6aRBUNyXOKjCaGjPahOa1IEuFxK2LP5O6s
	qg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4dh85cg1da-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 16:29:35 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb706313beso140277885a.3
        for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 13:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776198574; x=1776803374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXFqnVJ4T9hxAVeyiDV1ooSXjwN82kyD0WFAZyEIayY=;
        b=hDTqTfpcJmwm0f0otEUC+QLP/nb9Xd3gLdjYRlUwxzpD29bjpZah2uuLqq0JKT173y
         b9Rc/QZXG+HOZ1gzukgUck5zZ4pjU955kqFeLrDXpdYkWeBAtxxoPDbPCWfTIJgxHk2U
         a9vkS87PJDsAt/t7sLwdUF5wzO9CQnpLvkLtGtYHYmXRXUFpvAG1rmGuioxPxfTkshHE
         wYJO8K7AUmbXvLtvYZkIf61bHtmPOGpaUdOs8d/gipCkRdirZRtFNZHZ3nRiNSimul4Y
         hn6fpVVm6RO18/Wq+0TBOvsoDnncf1hE7uvRXFg3OtFGsxYEGnSt5c5kvNrE/ESi00jC
         B8Fg==
X-Forwarded-Encrypted: i=1; AFNElJ/fptiVJpC/VO3PzmF3lQL3pnoZ3ecVFL3uJO5FWnFzjYb1jtKUTHRE8mD/FW3Jz6SXx2pK8Cu5SNjloQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQb0kooI6MVwQJ5Q5oj70cxRpdkwMCPiEJjQsaMavQ+Gy4oWo5
	cTarY1Z+iq9yB9nyLJRwWewaJsWJH1KbvFU/ne5nVVWlFv9urycFWniGd4wPEuZAT2v05qSDkDc
	yOLK+pxSWvtXEuClFkCkDRr0WxGbyFpd54ihR/y8tJnTOxd+0/eQsblyC3230
X-Gm-Gg: AeBDieth80e0yEF89uDR8+MGV4QWF6OogPkSxUvzmoJaN9exWXAfmjjmzvSggK4BIF6
	ffyHIVd5dhDZnLpJGUgTB9/fjQ6jT4NWWNsvWVkW9A2pWTJw6bDO4b6QxmAMJWLun2yyYE0gN4H
	U8tzNo0ysOohaz9RxkoV7Qw4c/By23YnvD8P3YWwaXYm+KYFjdBvetSip9WE1W+0OrV0KxZ9T7f
	dQu9tdK2lMt5H9tXZ66YIOfaVBWXVjeF5SQLxUbLrIXwahsSvYX38h3dFXedHq7l3TeLYXgiZ0O
	P22d5l1mhS8Y/1piEE1Q7eKohrXucD/jtUGdWsyVAuzt9atkEenOqNUREwnHwqrFN4vYoLUcuek
	d3pVqFSg9Pc77SUCY2cVWGGreWVks8UPPBM4BQ2YGFZ9F0Tdk8zsmMob05mQ7JyyKfIted0o=
X-Received: by 2002:a05:620a:a281:10b0:8de:b9dd:8528 with SMTP id af79cd13be357-8deb9dd85ebmr1694559185a.24.1776198573929;
        Tue, 14 Apr 2026 13:29:33 -0700 (PDT)
X-Received: by 2002:a05:620a:a281:10b0:8de:b9dd:8528 with SMTP id af79cd13be357-8deb9dd85ebmr1694555685a.24.1776198573428;
        Tue, 14 Apr 2026 13:29:33 -0700 (PDT)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849db4e6sm131911086d6.4.2026.04.14.13.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 13:29:31 -0700 (PDT)
Message-ID: <fd94b108-22c1-4eb6-8fb4-b009214976dc@columbia.edu>
Date: Tue, 14 Apr 2026 16:29:29 -0400
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
 <7e468bd2-e52b-4165-95c6-3f04e1dca21e@columbia.edu>
 <fb64ba71-7284-4768-979b-84919f2aa5f0@kernel.dk>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <fb64ba71-7284-4768-979b-84919f2aa5f0@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WVKdX6zxZ_Ot81B5UMRNl3ghhk-z9cuM
X-Proofpoint-ORIG-GUID: WVKdX6zxZ_Ot81B5UMRNl3ghhk-z9cuM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE5MCBTYWx0ZWRfX7c3Kga2+6icm
 GSCuCPlR+yIsKMsspe/O01JbQ+Pk4TE50mEgcVqsIm/rkRD+ZX5hqvCRRX/+EHsByqEBX4eafpp
 p8Dejn+iB7Y8DiC6iMqF/W2cAjueC0AbiNbtWp6kSSPaXveORXWL5h9oxbKIHNuPVfkheduwx1B
 t28M5WcHp+6HSynsfWV3h/DECQGqVod09Ms1Y5D0REZytdGLhsc5z8CBn9TDSG5ZfVbLq6/rIDT
 2rZx1vwPyXm9668XifrdabrUUk2a55aOsVBP3uC32J5e7BQgWsLug730rL62xj/qq+7XxwJjjRF
 ZIzVtu0GJNcZV5uzGKgZPz7o+on2pQjp9sLKP6ilWBuR1k24fpZEOudREol1WtfiNphQMF2J0/s
 un5MqKxT3M2KrNEZ4WxFUi0tMDQHvInaYoaNCMIvHbWTA1kpjzzyeIfRIYEb2RiyhrN9Ikdsh+/
 G4i1OlVDsmr02x2JDAA==
X-Authority-Analysis: v=2.4 cv=RIOD2Yi+ c=1 sm=1 tr=0 ts=69dea3af cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=g0XPL2zXmNQOemVH8wcA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11759
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=10 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=10 clxscore=1015 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140190



On 4/9/26 8:46 PM, Jens Axboe wrote:
> On 4/9/26 12:54 PM, Tal Zussman wrote:
>> On 4/8/26 7:36 PM, Jens Axboe wrote:
>>> On Apr 8, 2026, at 4:51PM, Tal Zussman <tz2294@columbia.edu> wrote:
>>>>
>>>> Going to send v5 shortly -- tested with and without the llist reversal and
>>>> it didn't seem to make much of a difference. This was on a single-disk VM
>>>> though, so any stress testing you could do would be very helpful.
>>>>
>>>
>>> With all due respect, a single test like that isn?t going to be that useful. I'd be wary of making that change willy nilly and just thinking it's fine, worked fine on the one case I tested?.
>> 
>> Understood -- unfortunately that's what I have access to at the moment. I
>> can requisition a machine with 2, maybe 3 disks, and test more thoroughly on
>> that before sending the next version, but that'll take a few days. You had
>> previously offered to test on your big box, so was hoping that was still on
>> the table :)
> 
> I can do that, but I'm OOO for the next week, so won't be until I'm
> back.
> 

No problem, thanks!

>> (Although Christoph seems to have proposed moving away from llist again)
> 
> I think that's a good idea, not a fan of using llist for this, in case
> that wasn't clear. These are per-cpu lists anyway, and having a constant
> overhead is better than needing to reverse an llist. IMHO.

Will change it back for the next version.

> -- 
> Jens Axboe
> 

