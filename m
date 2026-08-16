Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCCEEBB
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838507; cv=none; b=ea84tnuKRykrDdDS1CyiRx+eGhmxf9roy1YqWbehq4DXOPjaGpq5LfL7CcuapAWA8r80fhxtywPI+W6okc1ObedjVONZrYjVVYyVwLu3IghjG2u7HRnton2+D3nuIkgpAdERAxQDeT7hw0IetGHDSEwZ5nxTl7ZJCRgUgRlkbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838507; c=relaxed/simple;
	bh=/w8cdEgqBWZlT+wRyBFt6zqVtytVud0ePjJMWlEc9W0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FVo1EdBecDkd8tUcng5z6ytRDBLGCJ6vej9CyoK1K6APORPMx5/SlGzokRWNcaXFgg3YaI8jz3aSh46sdHOV/QgpmhmHryD6qFJJaaj0GPcuEwt7k80sViA9K/AhAMJewLscJOw+eL39h8hSNhTHfkQv1wgMsF3GrGrjikUu4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ZsETvD4r; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ZsETvD4r"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-48a0ca07c38so1380977b6e.2
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838505; x=1787443305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALgQeGqc047M3C1ax7rnZ/RcuKeWj4zaPLEmd67nsyY=;
        b=ZsETvD4r00XkCLAQFVZalrp08gHNcWRqXkBqwRyqitDGWkznI4J0ofdlX4woobBPt4
         mdaeFM7VVNj9qU+uECBQW8FyqYwxXoVOKS7o86gjHgckRgDzmLqGUPjcpCTRyShKogBG
         p5UcSlhGXHoCS5XN6LIybsveW8tjTZcx3Cpfgtjyl2iXjFcWFgdiidsoFzLNyjGxuS9D
         XkqDcHAfQ7bsTV7A7xIrhuGifmLxrg+j03jm7Lxn4/Ls0lGtZE9XQVmF/cRWNYQtg3Nk
         02WAT3ctGSTLEQOvpMAgKtCcg4uUA84dqn545bRnnEOAZvL8lZwu2FR9LPIzkmXnLHmR
         sokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838505; x=1787443305;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALgQeGqc047M3C1ax7rnZ/RcuKeWj4zaPLEmd67nsyY=;
        b=cwF0owRFgfm/HLT3XkaHcw5+iy46W0E9F/N6KPGewf3K5aDSI/Jxo2J9SGyN+8vHgw
         LzXPzf+ICRQNaIj+koI9z8+VXFtTMLSubi2PdXzMY/MGEjEfuO08fB23h8xsvI/zmWtN
         nEwB9FVBrlFID+OpW2tIPjmIbpAz3t08G+Czw6WyK62yD4uF6q7Yz9nYt3Mn+PRpJJrX
         xugP7HM7pFVriCY7+xHERSJPWsT/UNPLdB87V/Wr5rZnankhMSu4LEveCfnLPGfz0EtY
         NExdVcHLjDcj/r2L5If7ZSzS0LKb538voeP2+oM2Gnx4tQUbO6v+a2mdh73A4VwREH6B
         dUOg==
X-Gm-Message-State: AOJu0Yz0YHY7F4VkWXXqOvjgwm2khxXTd4oHV6/sNwUGKx3N3Vbv2EN5
	Z51hLPOkabvVv1NhOnZ7u3SVF1nX5fD2TEGb9lSFa0mHiNnIPnMv+53ZqBMaVtxcLes=
X-Gm-Gg: AR+sD13IIENOZTS0bclYroqXLCTMnA8DANtZQ8kKH0Q2fJJhMbGgXrON55ATBWQP0qS
	4i1gY/rVCMHImSs2uO9UYOt9UWKX6TD+E/N3OliV3yyQVBWYVmyzCrdWFt8zs31RP+jvOZo4ddt
	+pbE2j9qsSCxJRRzLYcMXkbFfgFGUpEiaXlELl1t0oXvv4l/T/iYdwCpqsA2b0Q5Y5J3o5k11HE
	zz9Rl4mVRtZucwGAIdJIoXFHlNhQ+UoiiEjE8iEnUsdWfW023VZgacIjUZgefDYkhMgea19DDPc
	7jbQ8N0hKLG/2jcbAcMWcAjVlJdwvN6GBC1h2F4ASWkadHEbqFyAFyQjGlB+Ne/+fKky51ud3Pd
	C3kyGY4XWTQhMIAdP74IV+3cNvv0K6CT0D1zpprWxnK75S8vwN2BzouRt7S0r3hrxa6hBHAY+dk
	pBGOKdK6y2YZzRqE9MVk/EBykpkEz8/7P/FATWhdYLo16/29vRRjpl/fUVESJLkiYFTCWkVCJhi
	bZi5cOQDXUEQpBBqQZkCd/66IyD51s9ShJrrTXRCQ==
X-Received: by 2002:a05:6808:138b:b0:497:da47:df4d with SMTP id 5614622812f47-4b241cd7e71mr16068744b6e.16.1786838504781;
        Sat, 15 Aug 2026 17:01:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:01:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: bvanassche@acm.org, Hongfu Li <hongfu.li@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hongfu Li <lihongfu@kylinos.cn>
In-Reply-To: <20260812040729.27551-1-hongfu.li@linux.dev>
References: <20260812040729.27551-1-hongfu.li@linux.dev>
Subject: Re: [PATCH v2] block/mq-deadline: Drop unused dd parameters
Message-Id: <178683850140.1984298.12257546302340935901.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:01:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 12 Aug 2026 12:07:29 +0800, Hongfu Li wrote:
> Commit c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
> left the dd parameter unused in deadline_move_request().
> 
> Commit fde02699c242 ("block: mq-deadline: Remove support for zone
> write locking") left dd unused in deadline_fifo_request() and
> deadline_next_request().
> 
> [...]

Applied, thanks!

[1/1] block/mq-deadline: Drop unused dd parameters
      commit: 7fab47863aa2a1680415bd73b7e0a4212a2ebf0e

Best regards,
-- 
Jens Axboe



