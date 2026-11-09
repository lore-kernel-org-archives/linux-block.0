Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249307;
	b=pygYOJ+ugNPO2xa+8s8lUisUyMfqXp0V5UXC+i/B31q/dsH45Y87t23EG+094ebfRZFK
	 udPvPxbx2dAcGZ2Mqs4Raou+a11I8KnlU7ZAtcksXFYH/f3t0+oQaWnLV0EuF2lps9Z6h
	 tlkFddFFu5W/OWOi4ZDbTjKia6Awt4tICjAxRkQeMlZGvRIRQaXFVHhMqugDYosa9d5jr
	 x1UG0XQW3T+qNjwlk0392zvIOWbx9bYlWTUor89NX0tQA1ejplW33FOACvL2RU9xJL3uQ
	 5CAXfSUq2IKG9d/eF+yyab1pd90qIQVHHHkKlSmPP0ADjtVuccQTFXwFZWqRFt+xTLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249307;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rUkAN0D/BhV4eeepN5BkaPXtCpvrs73RQYqXxUHa58Y=;
	b=uWdGGjFteVFE9PC/6ZirrN2npLO9RyDvWeaMdrtoo1YOCrUR52wsv9mSGcdPnD0AD4ys
	 Md9QfrFTJ59io32yKhKZqP428MaAie1/snqMSZB436buPRmZQkZgNqGpW6WZ5iKdjynQJ
	 Mh9O1nPqZ83tHcr9nv6A3JhbBeT6KhyRNc9sXaZBAfoLQVw0NA1H0cjiEmf9IKqb8JsSL
	 7qQs/mxNvn4Zp/Vk7CWStLSiEw+Kxozb5avb33H2HtGNm3ASWHi/jYY3hkS+OBVaxeFf0
	 I2qm5y4iJCj4AkAqvz6dWN79fYE8jZgiKpcP3LqevBjsp8/nHlCn0PHUXd7kF//a/Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="l1c5/v8l";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=TzTQAQZf;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162C606A5F3
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E162C606A5F3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=l1c5/v8l;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=TzTQAQZf
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9HYriN4025966
	for <linux-block@vger.kernel.org>; Mon, 9 Nov 2026 13:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=rUkA
	N0D/BhV4eeepN5BkaPXtCpvrs73RQYqXxUHa58Y=; b=l1c5/v8l49hmG858fai+
	UKKiQ9cU4c/8V70uMPbqdB6EqIOXK5UkRD67zYVJ7g9z5KskWJNjpCpK/5GCbEwZ
	OtFQRwfcBaaWbQeICmqIuzEsFQM3maFplPKYmMt4RnF0f/P41Skphkwcf+w2PsHV
	inDXihKZrJ2ip+R144IbTbMX/M+KgfSnB2XX/itGgslUqPKd8uYcdDwLrnmjoS9j
	USZhhvtSjUkCwxCP56zcLZrys8cs29eG8hL8Y0xgUvxqVJ3jTLBK1DFRHzRvrD5i
	BJONdkj1fWuvBAPtJTYtw1lJFf3jDBILj4iPygz4co7c0OqZMrIjUU4SuQGohGZQ
	lQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hujnqggru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 13:34:58 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c6c1e082bso20982666d6.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794249298; x=1794854098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUkAN0D/BhV4eeepN5BkaPXtCpvrs73RQYqXxUHa58Y=;
        b=TzTQAQZfq0XjUPsPaOslkTzmhx3irVPF938FT70tcVsvI6v3NI1XZz5NvlPd7o6cFk
         eaFKyGOz23E/d76UJyJ9nIBP3L5j8WDAS4cSHn9Q1rNFL6IDBIwWgCfJgrOZohU4/UF3
         jrEeHTU1waD4fHO68HtTIQ26sq0lfxUXULaUBJYPklefoFBJdReKvD8lc6ez/pbU1jSB
         ZwDQTLet7vMUTm7N7ozc+3gmgp/STNO4l9j9Vm8QhHXA5AImB9UiQE9dshyTBmlpJkZj
         X6NZV/22syct225nemTs5+lkfpJpWkMLubsFMQO3//vFGNoFgkt3zo8aDANNondVPAp9
         lUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794249298; x=1794854098;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUkAN0D/BhV4eeepN5BkaPXtCpvrs73RQYqXxUHa58Y=;
        b=Npr3hGPMzF2a1e04Z5eI/h9wGjE5djEvYNZPKkJzDcC13+ojXeCfljKHb368bO2VjX
         R+7w+q3Zax7k29sI6EFpk0D2az7HxiO59cthPXRrY8qZ7sJ+SS7ZIfurbC/t32yi2Ges
         LwAkYuL4kEjF03KuNB+QjIJkGbNh9VbDuGFwL2hUK9TkgicIWT2l4Go58DMgRBOrN62+
         5hDr5WjTvx+k+wiWvp9Ed+/yXpOJu0Hyi3aXo/UCTtq+XBLPRupMY073pHIu4gcmb8uN
         1oFQ3U0ewNtLYYO8dFoa7PYPM4XHFyxM4opjc+XckhB+s/YEvU2z1WomDte8EzmBwGIz
         m1Nw==
X-Forwarded-Encrypted: i=1; AL+hErFN/VsjRuy21B+u50kWV20W1xNumjBpj+V77CLxw/s619EkhXK3ifut+5qS2c9mi93y/AJpPI2RXzcDvA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+FHIiFx6bRc91Ehz/wN2ufCwXAz0eC1Byw9Doq65PD84315BPE
	P9cNHJUo3SI26t+cQz5etQdehzfbTCKtwLlGf50bDPmSlVukf208cSFl9UcUWyAFqNh+d9z3RIm
	Kf8xcW2P8JXKBYFg9mEjUXT65Ksd6vIqe1KT3Jj9A34Rrc+TG9AXVoSmls9MN
X-Gm-Gg: AYBFou2OqtgUfsTPuX2cCA3Ut08BNFMUuPmm+i6/QSoqh+MQh0evW2Gyt0sgyY32lap
	lAoNN2QwQmkJsXMPrBYg7uG69cEoTJI/1VbQWD0wqc6X0pprD4+GnAYGFIvqG2KOqllLtJiN4QG
	37323NImia/DWGwjtYYK9Okns9et36uLVtI/B/SF0stp1I+ikALpBE6GCyQm/wJuEFBY5dbVYQO
	9hBK4de81QLeUXMI96j5WK8d0Sx20vkkqrtVbiH2fpk0ih6I3niiPFS1FFX06T9CuOpaef024hZ
	VytZQng2LwD/FN6FwLUcAOvZkXcgsuoyMFsRwWTopiMy+JH1qMlV4LX66sRzpGu9M46IiTP1vGB
	Gone/wqtN5aMaEvXYlp1ZEZhErxz5il+9zEvwVpAMpMuPcwAOcIIC/lt3oT8hNr2HAXXFlh0HmX
	ZyKsVfmLepj0qNSr12fEmdncc=
X-Received: by 2002:a05:620a:4050:b0:93c:3863:ff7f with SMTP id af79cd13be357-9479ee3c1b2mr70605885a.0.1794249298095;
        Mon, 09 Nov 2026 10:34:58 -0800 (PST)
X-Received: by 2002:a05:620a:4050:b0:93c:3863:ff7f with SMTP id af79cd13be357-9479ee3c1b2mr70601985a.0.1794249297669;
        Mon, 09 Nov 2026 10:34:57 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-178-16.net.columbia.edu. [128.59.178.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm34634485a.37.2026.11.09.10.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 10:34:57 -0800 (PST)
Message-ID: <c27b9521-7c4f-41ff-88f8-55313b5f395c@columbia.edu>
Date: Mon, 9 Nov 2026 13:34:56 -0500
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iomap: remove the atomic write length check in
 iomap_dio_bio_iter_one()
To: John Garry <john.garry@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
 <20261107-blkdev-atomic-bounce-v1-2-f66344262096@columbia.edu>
 <3fc46788-d86d-44c5-8606-385d96fede4d@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <3fc46788-d86d-44c5-8606-385d96fede4d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ly0eXU5GpzTYA_FGfCP4kTOZLZ8qR_6k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3NCBTYWx0ZWRfX5TgvIbcVvcRJ
 0cu3P1SDt/sexs/+oYr47A7RQYfy/VXwlf/ziTr8TufZJpqPeQPxRa8AnhvkbVatcD7Lo8IGBxK
 FBYS8OphRRZod0uqxe6qla3vSD/KXuDp7ZgCVdNEjxnaH+wc0bfI8slj0ytFsDZpCkN2fHj55dj
 Oq2Yc0ppvDMjtaP3z3rPLZilMT5jDMuZs1+LIba20yJTmil/uLAbO3ni5INKIuhuj2y50tyhAGR
 t4eW9UuKEnjW+Pqzwi7B4qr8r5/X3cWqidNaiN5Y0cUxyjFdmeAD7miXu8vo/9HM8Wm6Tz1tzJM
 SeGFOsLwhM/MacfhYm9t5saO7q4bV56wShK0APqdr1ot3x2Xbrt08+JauGrAktsVbTyeMnJEfsN
 ajkIKXb2IGYG59yfbnk+XrAEPixsQJB5nKWiENDlgh9W9c9gU8KS34XD/90m9xBIcYVSfGVQZGw
 /v3k6rulbEgB1wMIM2A==
X-Proofpoint-ORIG-GUID: ly0eXU5GpzTYA_FGfCP4kTOZLZ8qR_6k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3NCBTYWx0ZWRfXz32JIn945tga
 usKhndLcHYJcL2/TgvrE9tRLs7SnN8oltKFRwAxakdiJBWeQBrZWIJdvf+rm9j+gA0CrP0p4oAs
 cxn7G0E9B/57ZPLcIwgwI2d5tu0hUN8c8C2zwo3kcwL7R8oB37ic
X-Authority-Analysis: v=2.4 cv=foRJ914f c=1 sm=1 tr=0 ts=6af21252 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=Gl6UJ28otdLh1ydVN8wMBg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=ADIp8eLfD24IfaEPE4MA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11961
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 clxscore=1015 priorityscore=1501 impostorscore=10
 lowpriorityscore=10 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090074



On 11/8/26 12:06 PM, John Garry wrote:
> On 11/8/26 04:24, Tal Zussman wrote:
>> bio_iov_iter_get_pages() and bio_iov_iter_bounce_write() now fail a
>> REQ_ATOMIC bio that doesn't cover the whole iterator, so the bio here
>> always covers iomap_length() and the check can't trigger. Remove the
>> check.
>> 
>> Suggested-by: John Garry <john.garry@linux.dev>
>> Link: https://lore.kernel.org/all/82978d5c-3e08-48e9-bf0a-7913e1cd0507@linux.dev/
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> Reviewed-by: John Garry <john.garry@linux.dev>
> 

Thanks!

> This looks ok. But I am just thinking that a CoW-based atomic write does
> not have the single bio restriction, so we don't need to fail the atomic
> in this case. However, we should have consistent rules for iovec's
> whether it's a block device or regular file for ext4 or xfs, so this
> makes sense.
> 
> thanks
> 
> BTW, you could be a real hero and add an xfstests case for this also.
> 

What specifically would you want to see tested? I can do an atomic write with
a partially unmapped buffer, with and without stable writes, and check that it
fails and that nothing is written.

>> ---
>>   fs/iomap/direct-io.c | 14 --------------
>>   1 file changed, 14 deletions(-)
>> 
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index ad041ac3252a..aca7cbaea4af 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -370,15 +370,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>>   		goto out_put_bio;
>>   	ret = bio->bi_iter.bi_size;
>>   
>> -	/*
>> -	 * An atomic write bio must cover the complete length.  If it doesn't,
>> -	 * error out.
>> -	 */
>> -	if ((op & REQ_ATOMIC) && WARN_ON_ONCE(ret != iomap_length(iter))) {
>> -		ret = -EINVAL;
>> -		goto out_bio_release_pages;
>> -	}
>> -
>>   	if (dio->flags & IOMAP_DIO_WRITE)
>>   		task_io_account_write(ret);
>>   	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
>> @@ -393,11 +384,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>>   	iomap_dio_submit_bio(iter, dio, bio, pos);
>>   	return ret;
>>   
>> -out_bio_release_pages:
>> -	if (dio->flags & IOMAP_DIO_BOUNCE)
>> -		bio_free_folios(bio);
>> -	else
>> -		bio_release_pages(bio, false);
>>   out_put_bio:
>>   	bio_put(bio);
>>   	return ret;
>> 
> 

