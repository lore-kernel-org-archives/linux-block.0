Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5464247773
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360523; cv=none; b=Ww1J4+Jg90Y9V2FL9BzLYQ+CF+QddSxonI7ST3ZglhtTosoAqAXYnBbK1hjDMKqzRs2hNq25D60eRci0YEzd0Q0O3paxJ62Uo6oRNY9kVBtUsxpZEY4dgZhey4EJrtrcyEXWTRC+eX94k35upjC6wWAIw62B0Xqe7KYVs51F0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360523; c=relaxed/simple;
	bh=r8/IlxEMTI4UoA0ZJiGSP8vpXu2Im/dgIkLMUWfYLCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSDRJP6PWYAdY4qwW+ToeVFvM3DYCBjy5FBtx8mno8rTPel8geuzSxMJg9d3yRqFmvd2CrtoMkUSdPF//95BuQ77O7YHqdL7WzAsVuBnGTJW4RakVF1oLD02bN0dutv0fs7ykaQ3gJp0OY+fnGj0rFwF96RCv0ntDGd+X1GdGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hf3EFhSF; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hf3EFhSF"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3667b0bb83eso418675ab.0
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710360520; x=1710965320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYRKTZr+WkXIWH/qAlNrPKT3CFUoOmxa2ERFXSZxcE0=;
        b=hf3EFhSFng5aUFVgMpc5rGgcRLkrRWLy7LO/I8l0bPlpNrl9pxCrSOkaLVU27eJhxK
         RO19f2+M4mY7ukO1pkF6MW3RDVSv0IULAdY68bb7zMebePbFJnvJ1v5l58PwYKPsTFHg
         oRrKtEJv4gUmUDiQg52GMWb/ZIhgwt/6RwpRj18zP0kZnt3C+B/g2xMh9hQycVXFGnar
         3WNjYvhGZGqVxN0p8XlwpV0BzAMU65Ipss6217t3qUD/IlpnHuCY5rZsVx0CxVScDM/3
         a97PIacjr2cvx2hsbzk3jJKG0F/+wA6VlEHgyhmr6kREffCPETgBvo1HujQSm1teMiaA
         1n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360520; x=1710965320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYRKTZr+WkXIWH/qAlNrPKT3CFUoOmxa2ERFXSZxcE0=;
        b=fOxr+Ep9GZHoWH1m/hLulqKSdlth8X9gCivfiwk/ucbVjyCW+baxw2cVS6jWkX9wNy
         59hIqjCD92QKcTZe+u3s8lz/6TX0Gd7UYldGk7sygu5fxAl62UFKpZVXG0i+em5x1Fk0
         /cQKlWKWKQIaBgxzf3A/0OdZJBUcI4DyoB8Q3wfogmqnx+WAZNdBe84xl0eZSxdLS2n1
         jKipFRYvLrldG9uqYpsmjvAV4c9/TW6l2ahusm8i73xJQix5ppqb2UiDrGwrxX4AodQ1
         05hxv2yfHtI4aHdl/Xr5Zh8cCmnNfFq32SKs5mkso1gz45fhE+JmF7T9gMAhNjWfwjvF
         BLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXneVzAoU2HTF1DlXJHS4XWCLbGfriQ9fdiThZD19Rlh1Fk8UZvDZJiS/Ra1OxLPtlepFQFc6jYljhLiH+7LqSNkzMcKiBW1ecEimw=
X-Gm-Message-State: AOJu0Yz7opcEg9UgygSQZSIK0y9Qx25wr28zYstTiyc1lwHehnkxyvQY
	YOavdiaDfoKvT7Y3JEhvglgU1EHrQ8AJoAvoWWizAy/0t5G9n6ZKsWpacNeOI9I=
X-Google-Smtp-Source: AGHT+IGTEj4clyY6rU5vULjDfU20/b96kofSa2jdE2U03Aqzu4dOnkhxxtYL6A38VATDXsgzNgguhQ==
X-Received: by 2002:a6b:7804:0:b0:7c8:789b:b3d8 with SMTP id j4-20020a6b7804000000b007c8789bb3d8mr35336iom.0.1710360520411;
        Wed, 13 Mar 2024 13:08:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i23-20020a02cc57000000b00476e8efd3f2sm1988895jaq.155.2024.03.13.13.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 13:08:39 -0700 (PDT)
Message-ID: <fc81a1dd-8097-429c-8e96-86f2187cacb9@kernel.dk>
Date: Wed, 13 Mar 2024 14:08:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] block: move discard checks into the ioctl handler
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org
References: <20240312144532.1044427-1-hch@lst.de>
 <20240312144532.1044427-2-hch@lst.de> <ZfHI5Vr7BOU6__rv@kbusch-mbp>
 <20240313200621.GA5756@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240313200621.GA5756@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 2:06 PM, Christoph Hellwig wrote:
> Also I'm going to wait for more comments on the approach in this
> series before resending it, but we really should get a fix in in
> the next days for this regression.

Yes please, sooner rather than later. Too much fallout this merge
window, and I've got other items that should go out soon too.

-- 
Jens Axboe

