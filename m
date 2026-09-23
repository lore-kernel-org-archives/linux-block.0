Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093437207F
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206748; cv=none; b=keyUBCzPxBBVKp38o3tBEeIwBcE7poTjlWTKkvRSGZgkgUSiiUozQUWcpvS5iLfM58DQwOMcuNRv7QSl6QBTF1aqnN481UGEKBYrcOoiclp+1s7c4JVu4//P5ndhLEkBkRdnvBqPomH0qsR1/6lCAveVmQKF3DQFpLh33mLdiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206748; c=relaxed/simple;
	bh=K3YyBaWo543pXNN5qq+I3FP7iBd5+S3J6soaWlcoDfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n98qEx6wMFQym9uNWrIJMS+Y24t6o3+54wCU/2MMh0ufjgFi2zGQ4na0cHqAkYozOTpgNQJ80Nw7ZNCePxuVjy5FF5oCjtiep4Ch6GrBgLIyumDWnN7FTAbaAKkaZ+tTrRC+OSbLGCQK5JvzwpSILvRNZNKeA7tBBwdzmegPeWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=hLztHIDR; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=LCHy3tMh; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="hLztHIDR";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="LCHy3tMh"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNCO9C3593989
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=vK7o
	meZPmtdnE0KTnf60DcGTqHv0vNuINGT1nP6QP54=; b=hLztHIDRpVz/vKYKc0rl
	QKrD16ths0N5dqHrCem5e+EQL9IuSt0fqM22d65lCGvuXtM7Hvzl67AWqHVab/nB
	hAeepXwjTm8qUGuB5vIoAgW/T8gAzjF+Tt66hugUCVo045JJiG2yoeenlnS8XrMD
	Ayb6u+ENX1sV3bsOWsfVGL89eY6OrvjUirMLrwam62QWNmlhrOPBkudiTYj3+9rD
	sqWDAhNeQYKewpPcNcC30KQrdIackUvGt0/4TptOiJuO3SFzpsy37QnTCEzQWtpP
	p6cfRZhJ84rWESFb5KjgyXA4WKnRxFswOoMPE2HjsFGqTlXDef0P/FSR8UCe85Hu
	RQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvhw6v388-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:39:04 -0400 (EDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so1364082a91.0
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 16:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790206743; x=1790811543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK7omeZPmtdnE0KTnf60DcGTqHv0vNuINGT1nP6QP54=;
        b=LCHy3tMhf4MYPrjFXKqKuIkYoNPNkfGDZiTy2NPgDkVt89j3j+MuKZqD5eq+GqiYEO
         swCB3DXmFp4HR5E5PpoBbuukdnDMxNXQQ86J4J9GYJ7g4ZjnMWQu2QbCRXcn6RBa0lVD
         r1rRTjHUPOLNtXd9vlrMyblRp69fhPPv+qQdVYwYg8XqqJ1IY6MhaihDOeHS2NjEzVrn
         GwibLeML5DZz9h4+Wt2WYELN7ZsbG7K795O/mUMLEzBFvziJYQv3hLHZje2YPPR1ax1R
         2ytZSssu7G1I4pnTVa1NIPfOzuq4kYjdbPvfaQ4gWyrKZroMdGVUaSlWFaHvXJSx+egM
         aENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790206743; x=1790811543;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vK7omeZPmtdnE0KTnf60DcGTqHv0vNuINGT1nP6QP54=;
        b=2uN1D1u6A2CvVcPoWy2UUldrf7SbISPMkd657jqjNMgryscS5p62UnRuKa+r83NHKh
         NyHQey8zmhmOt1u350xvibE+nNwSNW0SOCcytAFbLTv9jpNntl2k9l1encmiUkBmk2th
         zBjTO9HiaGI/L6thZpNIgdZh65t07QSZX1LlSeISZ08FtkA0Px7eM9qdEvvQqieo4ij+
         dX6CaAb0fKN0rzzVYj+Bt0oWTOX0sdIQWBir4FJWrJL4aHjOcU/sfWwoqcmirB3BEKNa
         +bJWzdJsuHIF4c2YG5nJECWaWPo+n43uQDAvuyVKnzo4DfpP1oI08Ra+BVTGXv1FQ9YF
         E6Rw==
X-Forwarded-Encrypted: i=1; AKwUvBzouC3Erz/ldmtL8A3OcfsC2EOPl1lXVKlrC4sNrVl9Gz5l1d+XnR0WddIP5q59ktJqrta+0QFN/zh74w==@vger.kernel.org
X-Gm-Message-State: AFuF++nKf+FljLtjpCudrcg9jcyo36J56CoAmwiGp07JVn5pFYQvqj21
	W/eMD+P/sF6Wo0MPfyzNwFH9rVgfo6b/R1QbqylnRLkZPmYmBcXERTaDDaHo+/yqijTunCSzw39
	eRzPZYCfJhYWlJdxb583v5qwiOULSv22Uq3EEeAzezBGVsls0A2rcQ1vPI/Iw
X-Gm-Gg: AYBFou2GbxCyxoEVu86AXUo551IP41YWZC/kKgcr8PFWwudO+2e1mWE969XfDa5+vpL
	2sClIm7e5DYstWuZG5J0KorvPKl8/F1/23fzLAxGKieXIgho+CKw0533OsWxFw0Hu8Sf9eAOZDt
	67oAEAqkLZ7B0BzgW5NMfAqeXXVXDX8JOTxvuKFZDGb7Srh5fWHEb/hQsGvieV0YnoCDTykYS5m
	qvzbp4mU0rSsqRQ1K+wm0X6VLnRuOwEW8NKBwisTtj6cMFhkqG+wcFwKZ55Xp8GoYvkjIgkaS6y
	0H962CSy+vHCAjbhLc0nxQC9pewE4Y4QaBumcPjcaor2Irp9/i62SdhL/p+GtQMdKThIHu4xoaA
	7cj3uqeZsiecm1EUTfU9C8qryQyxvpaV3ZqhE/Aqm7Huur13r5A==
X-Received: by 2002:a17:90b:270d:b0:39e:6c6a:4b6b with SMTP id 98e67ed59e1d1-3a098e006d2mr535122a91.53.1790206743530;
        Wed, 23 Sep 2026 16:39:03 -0700 (PDT)
X-Received: by 2002:a17:90b:270d:b0:39e:6c6a:4b6b with SMTP id 98e67ed59e1d1-3a098e006d2mr535099a91.53.1790206743134;
        Wed, 23 Sep 2026 16:39:03 -0700 (PDT)
Received: from [172.16.0.184] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec711sm1248285a91.6.2026.09.23.16.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 16:39:02 -0700 (PDT)
Message-ID: <4e25b2c3-7030-4084-8202-beeea9f9e026@columbia.edu>
Date: Wed, 23 Sep 2026 16:39:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] block: don't fall back to buffered I/O for atomic
 writes
To: John Garry <john.garry@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
 <20260921-blkdev-fixes-v4-6-e2801f71ede9@columbia.edu>
 <c0613627-9801-473e-8120-4d4a83133391@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <c0613627-9801-473e-8120-4d4a83133391@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NyBTYWx0ZWRfX8NtqJbVGhGpc
 5zt5qk0P/bJEfCFqd6K5Y1m8gM/Zkejf56aemWkrUoC0pInXosZYkZzY5Hn+4OaHJ/uBl6bU7e5
 K7JDNEC0V+tPreqY0ctJV1e/gk/mgS4p3wF7RQ952Ih8NE2OMsF3
X-Proofpoint-ORIG-GUID: Wk3-LT8KhraKOnLgOXpvT1J4px1tBo6Q
X-Authority-Analysis: v=2.4 cv=HcaB3SE8 c=1 sm=1 tr=0 ts=6ab46318 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=HS0_KwlRLz3-zwHAltEA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NyBTYWx0ZWRfX1VfMRQPmqO2P
 JKxdkHLx664FnMq2ZZWqHjlxyOT2C4WHo/huLrbVBsvSCHjqyX/TSKaQf6rl1tFgW3pyFpGmJ5J
 8bcOQCjvwfDQp5dNJBsqZYV2gMboRvjNen8dRmS2IPQWE3U25ls8TmJX/ijBkhWL63tEPJQPBpk
 Ham98Gha/2/ArDuMbYAeThEiO8doa7ZuNEYsxewcxDF0jko7qjDVSUt3hYA14LulvO4gbQappeA
 uE6xIeKuMCOgWpG3UWHlIQGTmUY+Hqf8sHigb7qf9HnARF8RfT8+1F5IkDmNpWCZ1Gh3TLISDYB
 KHrw7rYzYC5JQnrqbogOYQIbh1W5+raP4QF2vjgAcKj82v8X3E7NvLUadZx6zicG6cdCGSMV0AV
 uNbbb6aBLkDWejEhK6jgzu4a4rzUB1rq36nc/4ybOXCf1tn1Vjt85kEEt4+MoGC804My8qWcJpd
 ELs6QFPq/owYg9PcH+w==
X-Proofpoint-GUID: Wk3-LT8KhraKOnLgOXpvT1J4px1tBo6Q
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=10 spamscore=0 priorityscore=1501 impostorscore=10
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230097

On 9/22/26 6:05 AM, John Garry wrote:
> On 9/22/26 03:54, Tal Zussman wrote:
> 
> Note that I still think that you can add an IOCB_ATOMIC check in
> iomap_file_buffered_write() (until it does handle IOCB_ATOMIC).
> 

Will do!

> Reviewed-by: John Garry <john.garry@linux.dev>
> 

Thanks!

>> ---
>>   block/fops.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/block/fops.c b/block/fops.c
>> index 90777e8a9a6c..7f23778f6b81 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -766,10 +766,11 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   	if (iocb->ki_flags & IOCB_DIRECT) {
>>   		ret = blkdev_direct_write(iocb, from);
>>   		if (ret >= 0 && iov_iter_count(from)) {
>> -			if (iocb->ki_flags & IOCB_NOWAIT) {
>> +			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_ATOMIC)) {
>>   				/*
>>   				 * The buffered fallback blocks on i_rwsem and
>> -				 * on writeback of the data it copied: return
>> +				 * on writeback of the data it copied, and
>> +				 * can't provide torn-write protection: return
>>   				 * the short direct write instead and let the
>>   				 * caller retry.
>>   				 */
>> 
> 

