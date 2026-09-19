Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E171A6835
	for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789794837; cv=none; b=hHCGBizewWBmwimP9spLvhLmWFgjNciA6WxKzxkaLKPKhBxUDcnOrKr7s8BWQxVD+WVioJfLVj4malWF8ZPyoVo6TITyPBcjl+F6XA9o18FiI4N3GXPHwjJLHVgyfaJkaDxseb9pJsUKzNNGsxuAL0ngcHfma4n1If65qxpEKxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789794837; c=relaxed/simple;
	bh=lHMtQlPa3byL8jNAGsmF9r4ihqPLoroI7pVk3f2IUP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mY79EugurZ8w3fTjg+zyxSnAWL3L1LIv+du1XH3IQiVjm+IUDj9oIl7kCfhmzWuuGOx/h5l2fQoP5rQTdRgibIJbDF7cn7PaHQDKS1xAjFiq7yaUn3dWP0SOOqseB6jWsYjeZaGSKlZs87siKi+gTZ58MKu9jM8+RkhuETkroI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=irCZIzt7; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cRJvhO3S; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="irCZIzt7";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cRJvhO3S"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J4XuMA025472
	for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 01:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Z4Q4
	0DsBVvRwmAo7kP6nqyDzh2DHzkNABJPrQkBYyR0=; b=irCZIzt7QN2OGKSHeBqJ
	IBAc5wsheklaKYWUf9ZRRqSrMikIoqLwyqRpFdvRt6zDh7Glmk6sUygNHOisQDqu
	MEPlyKrEiWzDUv+ZeBQrWfP/oGA/6dWpboLDEuuPvMoZ+B7jiRFhimRCrKrWosv0
	kD3L7j47n5sX8JoaOvmOfSH6iZO8hD202h9vGmX1NDH6UKc0L2pqI9puGLNJqkg9
	IwB7/F/YWmDTZmLRyuKo/Lz6EwRzMOKGw2otj18J7N9Nn/CA5F4DyWCYqqHrpxnQ
	YP0LUM4MnU6pJfOmgUQks8nKgYcJuVfsfuhX+aTGNcOtdriuBOuGWzKI9o8X+8D1
	rw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gsc0225mw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 01:13:49 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e98e74535so31019656d6.1
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 22:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789794828; x=1790399628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4Q40DsBVvRwmAo7kP6nqyDzh2DHzkNABJPrQkBYyR0=;
        b=cRJvhO3Sy5SNKdZ5kFUW9wzc4pVcx1aKfHCFBHOouwQd25xGgI8fqtL2ZtQL+6sP5L
         4B7ggjSfeGY0CBLmS7nxKVnNkJLp5X9tqr08gyW1oLc2ENmGrT/Sw6aJtjlFVTvm5Ma8
         TcJkKqfWJovHx2k3eb6b+iP5nYobSCWYkzOZ//uRokVIphsj2JTG3sOaYY6JaJm9IoGN
         BTK/DQI5net7136AvDOe+Tg0LSSdDl47CipEws5LTFIQtygCvltDbZx+cYsugx7TD63q
         4w3Ch1Fe0QSnzbs2LidTJVWzlgsQ7nGqH3uq/5lrzXkaUTXxt+eHRZD+n1BjDaBnIG4t
         tjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789794828; x=1790399628;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z4Q40DsBVvRwmAo7kP6nqyDzh2DHzkNABJPrQkBYyR0=;
        b=ty9a93cFTb/1biO+ImnKNU9wMBq7qPD1ye5smHRX/5kdd9lAONZ+P8bsp82eVe7Pff
         LD9jSZe4h2GjUSGqSKuWfp7lyc+P4WiYL7GYIWs0TuThtgPu2+UjxW5jdOr1PZ/r7t40
         Ofl8gA4OKd594D9h6AO1GBaKPKQzAfqPON3WA+P6B9ZLsPkxCF3fCylKeZGhyA69jocB
         7tImdm+XBq/41tQbWontRkQKH4qhl2be7vlp9L8AgbaejvslWPDZzpjwYIMIOOE0EmHP
         DVVyx44uubZjphTOyViSZPxLb58OLBBjdcEWvI8WbdHQBgeLsIQUI5bSp+nbPww3XqYU
         USLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJI5kH5b90Ts4v2xvlPeh7BEIVluCgrzeM8iq2Nyn+eHiLM9nFKbZbDgkeAP/+neERlkurcbRUJne6sw==@vger.kernel.org
X-Gm-Message-State: AFuF++mAk62TuVbtcLteOMtHiqARqOQb/bzgOjM9uiZzCO+mGF6EA5uy
	r0fvE34ao147Ms0u6H2ph9IqbzP7qyKUY9gGz/2yNFfm835QG81664aUgrkeqDzl5Lp/VhKX9j0
	SGXvlXEuoQc/09G5mZhH2SosBdp1NWCprjtdq2H0dzrSn0KdKhKphzFiNTejIhYSiTi5T
X-Gm-Gg: AYBFou3Mo9wSIgpzkhJNDDjjfEMa4CYQNUAGhTGgUDWfV8JAtitCb7nz1zT0tx9wH0J
	wMzb4oTOPX4FxmSMhRMSfmPMBGAh2QC71RwdDfhZ6phEM2hrFjoqlV5bOBrP04SCLgpJhw4inFh
	2L0TFsKLNqx0ixVKQUjFYLwtErXVAP/+rwnQuvqLbJ460o66ikJkImlfByxp96Z6O42tnekpUL2
	Kdj2ncBToETaWNtsndx/Ukt5sNUBt5LP2MKcNhbszqR9ghcCCD4PiT6VMIg4byHcKLgPLL3HITB
	ea3l7dSMu5TfNr2K46gY2rfB//zTNZH29hdQCRkX7UouyR1UEHql/wVKdkMh0gckhmGfg5zcfdZ
	3DCMD6+f0zkjP3iEzlThnpQnUsAaRLFOXjrr1rlHvP1QamP7C
X-Received: by 2002:ad4:5762:0:b0:912:3dbe:9ca9 with SMTP id 6a1803df08f44-912a8065566mr1513646d6.26.1789794828568;
        Fri, 18 Sep 2026 22:13:48 -0700 (PDT)
X-Received: by 2002:ad4:5762:0:b0:912:3dbe:9ca9 with SMTP id 6a1803df08f44-912a8065566mr1513456d6.26.1789794828108;
        Fri, 18 Sep 2026 22:13:48 -0700 (PDT)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260a309bdsm13061686d6.12.2026.09.18.22.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 22:13:47 -0700 (PDT)
Message-ID: <30714db4-6c6a-4189-8872-e7866ad53de4@columbia.edu>
Date: Sat, 19 Sep 2026 01:13:46 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner
 <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
 <20260909-blkdev-fixes-v3-6-1a5222c6e8ad@columbia.edu>
 <20260918084315.GA12283@lst.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260918084315.GA12283@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDA3MSBTYWx0ZWRfXyQncFnFfIw4l
 w0EUWG/1OHv2j/Tg1DMLfYCLROxnfALzohqcZtLMUhfbMPIdfAPbEfo+IKc7MfoTg4eZr7Xy831
 pjjNSpzie1FGZM65USwY5EsoyCb8ckUsWNkTl2l8uoRDJQzc9zC6Wc7Z7WBLdkiCy/ZETy2/1ju
 yVUtt9jqUIN+J+uhuj5rlowxvjfSS+0GnHVm+o2+YP7buT6ldgipHGnquslqZsipPCa0ItlqEHE
 Dm2w7JokPaIsSk2bUhUWp753GunOlfUnToTMRf81Wi5lktiHuO/+1pzPT5llQgmdunWTLYOBAZi
 oqElMOpniBrAallM+ympjeLOOEST6czh8X9iMh6LFquaj2JPbZEmy+8I4cz3cWEA/hiSsTprJVN
 SY1MsFIea4c9UqWtFplsvt9m+kleIaSptzmFazCctCdnl3nf0hEf9zX3TIHyW0qppuWq0hmLnQU
 yr9DR+iZiB/4pXHEMjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDA3MSBTYWx0ZWRfX++p3CRJkGiLJ
 BVCR36IUxvqv6UCx2b/B4SFyjmV8LSaHBejJDXlNDSKDfMZYPEEtA5QagCCzg4IHN0ACfnJ36lV
 HztBlauToUtee/HHuifg+pnxl5YRIYCVXBL4b+EcSw4yDKHS9ePr
X-Proofpoint-GUID: HzgpHWZmbF8thtJrgxeb2cRJaX6-WtB8
X-Proofpoint-ORIG-GUID: HzgpHWZmbF8thtJrgxeb2cRJaX6-WtB8
X-Authority-Analysis: v=2.4 cv=LpMHWXdc c=1 sm=1 tr=0 ts=6aae1a0d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=QINKK4dj0_nbEauUZSwA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11909
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 clxscore=1015 impostorscore=10 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=10 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190071

On 9/18/26 4:43 AM, Christoph Hellwig wrote:
>> +
>> +	/*
>> +	 * __bio_release_pages() only unpins the pages still covered by
>> +	 * bv_len, so drop the pins for the pages trimmed off here.
>> +	 */
>> +	npages = bvec_nr_pages(bv);
>>  	bv->bv_len -= nbytes;
>> +	npages -= bvec_nr_pages(bv);
> 
> Wouldn't it make more sense to calculate npages once after the
> decrement here, or am I missing something?
> 

The first bvec_nr_pages() computes the number of pages originally in the
bvec. Then we subtract the number of bytes trimmed off, and subtract
the number of pages still left in the bvec from the original page count,
giving us the number of pages trimmed off, which is then how many pins
we need to drop.

If we just calculate after the decrement we would only know how many pages
are currently in the bvec, and wouldn't know how many were dropped.
We could open-code this calculation as:

	size_t old_end = bv->bv_offset + bv->bv_len;

	bv->bv_len -= nbytes;
	npages = (old_end - 1) / PAGE_SIZE -
		(bv->bv_offset + bv->bv_len - 1) / PAGE_SIZE;

but both expressions end up compiling to the same thing in my testing.

But maybe I'm missing something... Perhaps this needs a bit of a
longer comment?
