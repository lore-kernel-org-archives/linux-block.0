Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4672561B
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523828; cv=none; b=ovwdZ/6iZ82POv5eK3k9undhP2FABSfjljwVb7tX/hIl+/wN6k9Kr885IXp4ch36V3U8woxcAqBnlNMJtw3AAjC0Iteqxtg86Ql3G/ypnMzmoHYmFlnvWmH/EnSwBoS2oSNJ9S9Y7VF/xTS0ANeopUFpmib+j56itaXOHZjgPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523828; c=relaxed/simple;
	bh=gdfflee0FxYok2cufR/YN4PQ2i9iA0uIH4V6SxtmCIg=;
	h=Received:DKIM-Signature:Received:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=mpW03N0CT5muOb4dK1LBMKM4sUVCBhh2DFl52+OAS8/oiWFYeMyf2NTx6ys9ZxXJK+Nm4Z992Y2aljYCNX4IyL1Bflo9zlCPnrKrOeAXQfYOWMN0H8EaEOq63GsjM6v4GRe+Se9IechgNT6dvBiT0UH2iZ8NP1S8kEV0GTwWZ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ham9fnwW; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ham9fnwW"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HKUYfF031478
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 15:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=pps01;
 bh=77OoazkCf6a5qjMGULocfOrHZxKC8oy44xl6hJGL0uA=;
 b=ham9fnwWMOS8/sxNnmotsTu28t5gLdD2yOdskOa9cNsebwaT5j6PhKrGXY/CjWPenCP4
 osvORJfATa14kEwpgeBPZvgnU1Aw7GDjIhodNgKvqyTjG4Fh7dr/CzQjsln97WvuZwBZ
 SdfU7pgBTgeh7imCMUaXgc8LeuPprLIY3BzkHW7FNKFcXwpkKtp5V1DLprNB6F6YzfAs
 D80TNzwZW3GuMzVlwqPitk+S28bOxESzYiCI3TDUfnO/mtuNTTLxvVrLB30E/B5d47I2
 kDNEN+GOPv4rT6pkPA4Ty0KBtBW1P9qQftdgY/1252zlJ9QVZf8zhEn0f55xRf3OFrHT nQ== 
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 3vknp3329d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 15:37:05 -0500
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd98419c93so693303b6e.2
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 12:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705523824; x=1706128624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77OoazkCf6a5qjMGULocfOrHZxKC8oy44xl6hJGL0uA=;
        b=LMgp5zC09k+uLaAuZHazeNqDtSGGgLTUQNZzAIkuvbUW0i+x9qVbLJ63VXa2pPSq9M
         jv79B2f7PQrsmASZKiYsi1h4rKiH88EeG5/MmfOh+AUlYqEfBuNwjzTt2dDvhQ372GZG
         VQG+BtjWVHXuKTEsQ3HIB2WuU529LZnAUSdFXisns7k8NxES3MqQB0I6QCO1PNoWP1x8
         z2OkpoxpvJtSyehkvFXKAHD4B/RIeK1mWdVTP94Sz5wKFP79Dkx553NKH4WCMWN9r57O
         405AzD+kIS07PS94lRR+F6G2Mb4FzR8V3EPQoWWfiRMbID4uz3I6rPm/HA8D6ZcHAcAY
         01iQ==
X-Gm-Message-State: AOJu0YyjBXUH4gp2VlrpCOyyCfKTx5MXSsSy4gLeAybsXo0Av34vXDMR
	rFwtI6vmbN6zXhz2aGqnta1Vl2rI5RWGkVTrkvYZ5u268DSH+qkHn+H8/gW628/dtlsPDv695yS
	YUGHdUUpS7vdhg5FMPFgSwXMdEr/z/0YL44q42vfWXBu1zACtJBv/bQ==
X-Received: by 2002:a05:6870:460d:b0:206:7b6:9700 with SMTP id z13-20020a056870460d00b0020607b69700mr12273518oao.41.1705523824437;
        Wed, 17 Jan 2024 12:37:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt86d4ZGlSh9/6oJbF4iYxKVUqVwF/EgNCy87GkhtKYcK94BbgyZ0edU148z1BW4nO209gPp5KMJXU5HSdaVM=
X-Received: by 2002:a05:6870:460d:b0:206:7b6:9700 with SMTP id
 z13-20020a056870460d00b0020607b69700mr12273517oao.41.1705523824215; Wed, 17
 Jan 2024 12:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALbthteVP3BnZuQuGWfW-SviB64CwjACP2v1N5ayDVFpnjEOtw@mail.gmail.com>
 <e4347147-f88f-4a83-ac48-fde1af6a89e9@kernel.dk> <37b7836b-f231-4bf5-bee1-7571f889d6ff@acm.org>
 <3f676f69-690a-480c-850d-ff1d9e502e4f@kernel.dk>
In-Reply-To: <3f676f69-690a-480c-850d-ff1d9e502e4f@kernel.dk>
From: Gabriel Ryan <gabe@cs.columbia.edu>
Date: Wed, 17 Jan 2024 15:36:58 -0500
Message-ID: <CALbthtdU8=yiaq7wzQegf52M0A+a=MUzcHvaM-FeLSHZvrfQkA@mail.gmail.com>
Subject: Re: Race in block/blk-mq-sched.c blk_mq_sched_dispatch_requests
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: iqRqLYfWwjUlnX2yJ37JzhLQkcFLedoo
X-Proofpoint-GUID: iqRqLYfWwjUlnX2yJ37JzhLQkcFLedoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=10
 bulkscore=10 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=10 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170150

Thank you for the response Jens, and apologies I did not realize that
the variable is only used for debug output before sending this report.

Best,
Gabe

On Wed, Jan 17, 2024 at 3:28=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/17/24 1:22 PM, Bart Van Assche wrote:
> > On 1/17/24 12:17, Jens Axboe wrote:
> >> On 1/17/24 1:16 PM, Gabriel Ryan wrote:
> >>> We found a race in the block message queue for kernel v5.18-rc5 using
> >>> a race testing tool we are developing. We are reporting this race
> >>> because it appears to be potentially harmful. The race occurs in
> >>>
> >>> block/blk-mq-sched.c:333 blk_mq_sched_dispatch_requests
> >>>
> >>>      hctx->run++;
> >>>
> >>> where multiple threads can schedule dispatch requests and increment
> >>> the request counter htctx->run simultaneously. This appears to lead t=
o
> >>> undefined behavior where multiple conflicting updates to the hctx->ru=
n
> >>> value could result in it not matching the number of requests that
> >>> have been scheduled with calls to blk_mq_sched_dispatch_requests.
> >>
> >> I suggest you take a closer look at how that variable is actually
> >> used.
> >
> > It's probably a good idea to explain this in a comment above the
> > code that increments hctx->runs because others may also be wondering
> > what the impact is of concurrent hctx->runs increments.
>
> If you do a quick grep, you'll very quickly see that it's just used
> for debugfs output. Being racy is not a problem. It should just get
> removed, honestly, like I did with some of the other accounting some
> time ago.
>
> --
> Jens Axboe
>
>
