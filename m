Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACBC1CBE8C
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704746; cv=none; b=QUj2EKIPtZPc2oqdenC05JyFNTBOGY0SAWqsBa3jePeZuutaanlQkyjKoAPtAG79ocknHoEILeKHcUynLKFcIQUwa26JbYlIVAy0fwW1NQHekU5Szn57Wlj4LeicDS3tmz2xQv1KbLOr3XRrhMmJcXRcWToSZrv4Z8rL/4GRx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704746; c=relaxed/simple;
	bh=gv1G9Z96EFrbQZ1cbL33lVjm9HQLDsqF7DO+CEeipwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAP1payRj7V/4C60d4STget3D6N1GHcNWT2Odd34HppYnfljoBrrIUGIC0F0wOECBkmMUp/hB56lRPAYVgdYnDp4+T00k+HjiclZjCIoekkVOzNn9U1js8NPpAJEHFDBhROCSXIGzoAiWdz9vede5CoxMXt6LvDqo4ECqRux6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IPGSpriB; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IPGSpriB"
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-70a57a8ffc3so39240987b3.0
        for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750704744; x=1751309544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSdtfcO6yct73s8jNNwzmEbNNWfSJFlnXgpHHlfXObs=;
        b=IPGSpriB6GCWEeVCrU+cwSjFwPgBoPb9vO/iCH2hVghOb7ChU0aEtjjCppYr00MngO
         bxHBcg1tf2wzShARuh7r1nZLRYi29pdrHgKq2vvIGcPmejywWw8rScADIlPByuVHU51S
         qDMAUsvZBpBszK1WLcm2eVZIsIHTXqHbE1c4pMRSApZjK5xlC3hnOP7AoPkcKPwT8GiD
         K+hYQwDhc0l6yo+n7no77tOkh3k6okWU1AiPQHH4jQ+JEaJ4s5C4/cSpuuag1pvshnP4
         JVHe1/se8G6qOrRNNpjiJhq3t9i4SI27LGCR/z3yhDejpgJ0hB1Q9MfXK5hgm7kxwZMh
         NErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704744; x=1751309544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSdtfcO6yct73s8jNNwzmEbNNWfSJFlnXgpHHlfXObs=;
        b=HcEJsgSC7ejoyL2Bq8sCwLeEsEk/3nWm5bXaF9m2nE3z9Xmk2D8qUPnG2mDoSaMWsw
         ItOE+E6LbYUa8OK2POlkpAQ+DF8RIQ6EukcmFK8pRfasVdvpXsNHf4XMRyHNrfRpHWKN
         m8wY8xH4clDOiRAo4kIge1aA64707aJcNaHHrWHFoklmr9sy+KVNRjhpu8x+urP3Twn/
         N8HvTGvnZQqbQbsRTthvz4iRLak5EuRgALhOHB4vbyjqUIf4bKcHG8c84dEJy8ulBoqP
         EPreDM3h4IJaSCvnYGq/UBI1xyU0iUrptZl0sQi9phWkABpLJB6szM3LwGg8+Rc4pyW3
         kCEA==
X-Forwarded-Encrypted: i=1; AJvYcCW/rNXVfxiN2oH8t5Ik3kmUN0bc89QtSjCY2JOldAJDJQI/OA12og83u09/ygQ1kHLabTjGFzHRI51S0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXsgopnT4udXjVd3O0PZ+wETvFXS2WaR6ifYeBF4bNcS/BCN69
	HPFipxBInvorBULHsZaWD7DN55Da4YTpmRyhi2QKeT771c0J7uTa6IqrcCgqYyFKY18jJmC28ca
	Z/FQZ6bniwa/OhhS/67yT9/GUoHCbIMMzGJ4wtfLA8D+D585emxcv
X-Gm-Gg: ASbGncuQRANMydpbOlRh4kK0KJagBwQQNwsQ6PNpFlFSx3UiHMD8/EsKsvQNh8u2OFG
	xj0Im3jbxP2/stohmKzXkW5ZBvAI6ZkUPk+nyUC2tCEK87PH8nWfPn70KZnrvNKkIi8uduyTVsu
	uetcAH6MrFeTQ/OSMjZkEXNcdqvfnJ4Rj5T7HwmwKth2FY0DfrcRGqHPR+8B/G1w51Skg4RoO8U
	c5MUUC9DxwWOZHhKsTwLoJC7TSJoXC7EX7d7f4Gsaaz9J+qpST9O9X/A5a/Vj2n1Kw0Go3HAmxl
	BCaUr6cMzLfTJAsi2UslCMf46JR8a7gZZF7773AY8g==
X-Google-Smtp-Source: AGHT+IGDE6E8898w1M/iljDhBprZ95zKNBS1+iC+DsKwuQBLxDeFFN8qYAWUvZfADpnnp5LjhZ+kFacbcEyY
X-Received: by 2002:a05:690c:6086:b0:711:6419:5ce1 with SMTP id 00721157ae682-712c67610bdmr211314147b3.31.1750704743909;
        Mon, 23 Jun 2025 11:52:23 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-712c4a38e96sm1589957b3.22.2025.06.23.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 11:52:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D817A34014A;
	Mon, 23 Jun 2025 12:52:22 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id C93D1E40278; Mon, 23 Jun 2025 12:52:22 -0600 (MDT)
Date: Mon, 23 Jun 2025 12:52:22 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: fix narrowing warnings in UAPI header
Message-ID: <aFmiZpTDrJ5GSGty@dev-ushankar.dev.purestorage.com>
References: <20250621162842.337452-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621162842.337452-1-csander@purestorage.com>

On Sat, Jun 21, 2025 at 10:28:41AM -0600, Caleb Sander Mateos wrote:
> When a C++ file compiled with -Wc++11-narrowing includes the UAPI header
> linux/ublk_cmd.h, ublk_sqe_addr_to_auto_buf_reg()'s assignments of u64
> values to u8, u16, and u32 fields result in compiler warnings. Add
> explicit casts to the intended types to avoid these warnings. Drop the
> unnecessary bitmasks.
> 
> Reported-by: Uday Shankar <ushankar@purestorage.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG")

Looks good: https://godbolt.org/z/qovrerdhd

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

