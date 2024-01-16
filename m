Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E51CA8A
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424623; cv=none; b=EbwUg7YJeWjkNx7xfgy2jy3OSNsXWsT2/ic7YXjDsxEHWixdck5YVuzsmtSJqn1EZWRVzH4LluYUGy1rAeFd5DLPvKIuyTqm3RW7Ppd5cWZd5qr9vrVgMvgPPmSAL60mCNscnzRLUTmRDDgDYmyqEJ14VFPjpW4Ag3OVYGdOgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424623; c=relaxed/simple;
	bh=VIplDjKnxv6G4iOJkD77TIjv6qySJZ1um401u34+dc8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=CPE160zWMh2f7UzSxjA7NnmBtMh2Yuo9Q8FjImfzoj0OwAFD31/vAVbZXtSiFQKylQzkPuUfCbc/poAm0cRZXi+bf4WBzJC6BiubU6gwi024cTjs5K4k0NzE7/2/6gL5Q3nzRiu3yGm+A0zpiLYwgzf6xu9TX+FIN8Thb1AKcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OA+cAPtA
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OA+cAPtA"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bee9f626caso50035439f.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 09:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705424621; x=1706029421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QY4M63jGX67p6S9WZCI3HqN7p+hdyR5DfWJbbjEx2xQ=;
        b=OA+cAPtACVHGeLXVMS0wdidslXYBGBW8d9nm3skxafrlhjLirA//LPrTOCLNohDEiO
         5oGdXP7Je2F1FnCQ9P3sc1utOJqaEs4zLMtEqcAi0SkxMiDFGYVjSLvOMNZSLwLQkxQZ
         5vWzf+x44yPZW5TrkkwMmUc7tOVrMVmpQsN1VQBbNqM59zDBaYiVfx+IKefGE2LHoI65
         aVks/ZzOtwjMXw07So0gJjMl58hJxqKBD4YN1E4R6tEkYd2wYVOHd4rt/pL8oZSxuUdg
         JrE1DVZTOnYMZ4e2JdtKsQ53HiTZfjMDd4RWtx+pyR9wDv2kgZtPedwLXB1MT9nS8dDH
         XCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424621; x=1706029421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QY4M63jGX67p6S9WZCI3HqN7p+hdyR5DfWJbbjEx2xQ=;
        b=DoOu1xDbhn/CVmjU8x+wksblmy38qxV/26v/BN+z2MnprI7neFH8cBCFhts32T8zGz
         sItFamiO781hTFQnFSk9ziyIWokMk9fWrsDXEDOrGIh3xDu1mjjNXBB8TAlzyPeFYr7g
         sP9ac7TPJfWsXjh6FDJn8su6ouNalhApaAMZlzHjcbM+DGcmnDejboqferD8CCY3eV9i
         sdxqtLlzcsFPPK7zf70Gq7X38eSWlzqMvPJ/QtARGnckb48Xd6uAXm6+VJ+oPUg88UvE
         Y4QwlVEX/Vv9KvnWb/y/7/9COzQOePqo9673ql2h+Bhq1xiqmbF3Ukcj3xY7w0iqrMcr
         YZlw==
X-Gm-Message-State: AOJu0Yx+dvYc+f0iV4OLs7ATfaKw92C+6PxBOlKYa/va+peU/uTYsI9I
	3g3GQuu8VoCBkJ3OOBzltswFgHxLnSMEMryKr5T/E7jDeMPPTQ==
X-Google-Smtp-Source: AGHT+IEBVMI4TihyYpYwl3BKS+DmAx0+ElR/RL7HqF1Q3B4X2RPyUragAIBe3H20/oHQ8XJuBQSkug==
X-Received: by 2002:a92:c26f:0:b0:35f:f59f:9f4c with SMTP id h15-20020a92c26f000000b0035ff59f9f4cmr15291439ild.1.1705424620861;
        Tue, 16 Jan 2024 09:03:40 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i2-20020a056e020ec200b0035faf00c555sm3703529ilk.31.2024.01.16.09.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 09:03:40 -0800 (PST)
Message-ID: <7810fdb9-0fcb-428d-b2b0-03b04aa27a91@kernel.dk>
Date: Tue, 16 Jan 2024 10:03:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] block: convert struct blk_plug callback list to
 hlists
Content-Language: en-US
To: linux-block@vger.kernel.org
Cc: kbusch@kernel.org, joshi.k@samsung.com
References: <20240116165814.236767-1-axboe@kernel.dk>
 <20240116165814.236767-6-axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240116165814.236767-6-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 9:54 AM, Jens Axboe wrote:
> We currently use a doubly linked list, which means the head takes up
> 16 bytes. As any iteration goes over the full list by first splicing it
> to an on-stack copy, we never need to remove members from the middle of
> the list.
> 
> Convert it to an hlist instead, saving 8 bytes in the blk_plug structure.
> This also helps save 40 bytes of text in the core block code, tested on
> arm64.

Gah, looks like I forgot to refresh before committing this one, it
just needs a one-liner for raid:

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 512746551f36..4a1b6f17067f 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -152,7 +152,7 @@ static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
 	plug = container_of(cb, struct raid1_plug_cb, cb);
 	bio_list_add(&plug->pending, bio);
 	if (++plug->count / MAX_PLUG_BIO >= copies) {
-		list_del(&cb->list);
+		hlist_del(&cb->list);
 		cb->callback(cb, false);
 	}
 
-- 
Jens Axboe

