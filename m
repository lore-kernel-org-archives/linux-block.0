Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11107CF3E
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606970; cv=none; b=s/w8kFPgv47ns19NrGHwj0RM05ckldEIXC6xvbetSLlToZv+Fugtujptbz+KTntGxM+/EVx04/qgxro7nEFHLdOnVhRalwSj9Y+8uYZMea8WOPkfn9wJu+FrVAL2BGM/lawXfMN/xRauJdUtvenskf9/4tvtcN87eJgw/TV+LGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606970; c=relaxed/simple;
	bh=yrYs3zAVNq2kwCVGuRx1pSvpf151YbkI4EAnWLUAmvw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SvcJKkpqKW7a7MJFzU+mFE7+QhdVy0NxvIEGc25MbSszc4zGddJygXxgf1nw54FazMvhGHA2RmrfERH8lKnVdwxarvZ/UPl1YSP7JkW2v1ytL02BeWmZ7iUUU1p9r/HI9WigWQ1NR8Ofj4OmKhJIZAZcCN98qL3MQX/PviJs3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O5YfIGGo; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O5YfIGGo"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25075f3f472so111653fac.2
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719606968; x=1720211768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXjPL4lzWlI7eeaad+faprpE9Kk5VhEtAm4oytxFR08=;
        b=O5YfIGGoOxcS1H9S8k3UzhlwKY9VjUGLVXPsjyV+cX0Sl7P6Q7hEytSI3Uar0Drb9x
         gCwCM8CJf4WXz+gxU9Af0Rbc31/Q07GIgszhEg1ywjN9Uy9xhqwIATdKfMIKMA+zGFwS
         LWLSN6jHlyCdQc5lOmbJc3bXMmeChJxoGeRXwvVgz4E9/OxOS/cw50FRSZinkzSE9AJV
         PxMIws9jtS0P/9FmLhu58q/BL3RCFPPUeMev15gsH73NBM4Y5PSqBwaohqS5n4Ac/E0r
         xms4vy7YXqe2qLZxKg1wTUl3nLRRjoM2wRV2B4f1245nKsSerEpfEwRaqyN9x3nG4dpr
         SNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719606968; x=1720211768;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXjPL4lzWlI7eeaad+faprpE9Kk5VhEtAm4oytxFR08=;
        b=Aq5bgIde3ZFhUQB8k8POOWgbOx3O2D5jmRLX57fQ0G0mBR8fteXY6zVBXmGqsxygu/
         /GtGenvn6lQxFHKvzwCt+2x8XsRtXZsM35NawH59lUVP7k+d4uizo5G2NkSJKteJ5yEI
         GbcJvNbxLvIADkE2tk598X9xVcgRegJgJb3+wFEthWtE9e77LCqRgXyO8uDpGh56srZK
         HczqAQDc/O/ZJkR8d5O5vt+1aBsy/HvsMEOrhUvm1yxl2hgUd053Ax5WWHfyrOk6awbX
         uUqZPVmSyUfBAxSF1hf5VTjsKK2hXs/hRVYTkpcJvWOfEAsTGGuMPT3yh7qFgZHpR98+
         4OIA==
X-Gm-Message-State: AOJu0YyrvF+bf7je3q/p+fznu8xIccfaGOUy4mQ8ia/DmHEuf3qdzec7
	xFifsyaoqNel3eaMS62qrxxh7BYq6W58b+9U9EMw+oEviisHGvoCA1vnr2qBWn4=
X-Google-Smtp-Source: AGHT+IHjfrwNSbJ4RZgns/gNJ6BkxPazhuod6QRaKqFrsMPvegUYFHfIEbIG1j06uuW36wHeHnLcTg==
X-Received: by 2002:a4a:dc90:0:b0:5c4:24e0:26cd with SMTP id 006d021491bc7-5c424e02941mr2735657eaf.1.1719606967865;
        Fri, 28 Jun 2024 13:36:07 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c4149c37c4sm367003eaf.42.2024.06.28.13.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 13:36:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>, 
 Andreas Hindborg <nmi@metaspace.dk>
Cc: Christoph Hellwig <hch@lst.de>, Miguel Ojeda <ojeda@kernel.org>, 
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>
In-Reply-To: <20240628091152.2185241-1-nmi@metaspace.dk>
References: <20240628091152.2185241-1-nmi@metaspace.dk>
Subject: Re: [PATCH] rust: block: fix generated bindings after refactoring
 of features
Message-Id: <171960696681.897195.304829009055681051.b4-ty@kernel.dk>
Date: Fri, 28 Jun 2024 14:36:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 28 Jun 2024 11:11:52 +0200, Andreas Hindborg wrote:
> Block device features and flags were refactored from `enum` to `#define`.
> This broke Rust binding generation. This patch fixes the binding
> generation.
> 
> 

Applied, thanks!

[1/1] rust: block: fix generated bindings after refactoring of features
      commit: 5b026e34120766408e76ba19a0e33a9dc996f9f0

Best regards,
-- 
Jens Axboe



