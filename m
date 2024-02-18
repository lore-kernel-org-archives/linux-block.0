Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D9EAD6
	for <linux-block@vger.kernel.org>; Sun, 18 Feb 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708261318; cv=none; b=D09/xwmRhtj7wJ5280YsfUY+hGdICujvzFFaJ41BWH2xlLlPxoP6UiZvvVc4/XS/h774sbtRbMpTWUHsxpzUqSyOqRwHyAQ1BmY/AtyDAzXie7PtyfYCg5SyarBUTHlGVa+Ic2+wtBXvdQifRhiWH5YFn3fTC06GMsrdPSsq4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708261318; c=relaxed/simple;
	bh=zbnL6TDcSK6AC/D2F07Yjgf53xB66w+9AFFNx1ks/W8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DGJKvZuN1yj1/KZlivS/sLCCVx2UhDBBjOg3/c9shi4mQ318wuCdMjqu1kkwjxWcYJUkCefHaTyaFnxF1u9QlFxFHoODgASG9llz7qzcoSgjV4ucPNFnnKZ4OmWlk21WS5YeSV2lloPQ+0VK93/N+6c7MieDXqZiQ6gkfD5Ttao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gLDbvUzA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gLDbvUzA"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-58962bf3f89so1133381a12.0
        for <linux-block@vger.kernel.org>; Sun, 18 Feb 2024 05:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708261316; x=1708866116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuYePQZG9giieDNYVsec9OIcCA3TVx+bwOo9N5SvsvA=;
        b=gLDbvUzA57vUh5GtfLeVcMLk35FQkWSXw+81G6ZWwS8eZdDEVU9uzvnWuLod1cM5WB
         SFDPPel9C3xdleZDATiqig3zONAIUB9Cd1dzWeiZQNmkLM1h91RN4Gtadicl18xNWgi9
         0l1ZlyZnGtkxPtCdpHeaYfd4rbsZc/IV2g0mDRvU50LVqOsoBNLtn5te9DrhqsybddoO
         XjbK0sPrgVs0CvLm7OOALrnQLGrAFqbD3IeoACUvg5tCM6WdQLyT6lxwFoq0VDeaSGOd
         JzsQJDS+nzMkSC/pYL7D5p+Snur7WwRHfDHteps7jY+WgfqmAN79o+4dv3+Vk8BHiWHY
         EbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708261316; x=1708866116;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuYePQZG9giieDNYVsec9OIcCA3TVx+bwOo9N5SvsvA=;
        b=n1em9sfFqzchQ5RVnmgEddpeerg+VKhM9t16VK4C4MIoFlp0yaDTj4EDxmqn40/a9e
         aRiu10cXIrLnInsgUlxWlsVZ/9RTyupq6BNy9MMYmEPpjY1pgU6JCUnIjRUVjmOPe35h
         SRsG29S67M2unxo/92x8rKvy91D7d8aoh2w+qcptLw87qKhv4RQmTsv3Y0Qz8fCMICWD
         jA7nmCT6ZExemg559pb1AD0urhpWBchum/tYI+65XmT4z2sSgre4srqT0R0/Z1R2jLLO
         5461VROdphk6/O6LcF2oYlmfc4BjD7I/9ATeJEM2yDMQJHg0ETNvhJXqFSgLKrydSvM4
         ReKQ==
X-Gm-Message-State: AOJu0YxPxvLvSNeTQFoW+RmT1WexHqK6rHHAZYXuI2LV0r3G9LmvAZ8B
	FS6fj7NUVUioKadXSTH9G5mwdzFP0QMSlueDb+RGMzeVygbUqFCazVbYLVNfO78=
X-Google-Smtp-Source: AGHT+IEKX3t6Kj/HgmMYWJJaz/LJxic/c2Y15drX2IZ4kjfplvpusLpca3ojazyvGc3w8OY/xUecVg==
X-Received: by 2002:a17:902:ac88:b0:1db:94a9:f9f0 with SMTP id h8-20020a170902ac8800b001db94a9f9f0mr8166917plr.2.1708261315996;
        Sun, 18 Feb 2024 05:01:55 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001d9a91af8a4sm2685725plb.28.2024.02.18.05.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 05:01:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, gjoyce@linux.ibm.com
Cc: jonathan.derrick@linux.dev, brking@linux.ibm.com, msuchanek@suse.de, 
 akpm@linux-foundation.org, okozina@redhat.com, hch@lst.de, dwagner@suse.de
In-Reply-To: <20240216210417.3526064-1-gjoyce@linux.ibm.com>
References: <20240216210417.3526064-1-gjoyce@linux.ibm.com>
Subject: Re: [PATCH 0/1] add empty atom support to SED Opal parser
Message-Id: <170826131482.3482432.14386325887775454180.b4-ty@kernel.dk>
Date: Sun, 18 Feb 2024 06:01:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 16 Feb 2024 15:04:16 -0600, gjoyce@linux.ibm.com wrote:
> Some SED Opal compliant NVMe drives generate "empty atoms" that cause
> the message response parser to fail. The TCG spec indicates that
> empty atoms are for alignment and should be ignored. This change
> adds recognition of empty atoms and ignores them if found. This
> allows the parser to corectly process the response message.
> 
> Greg Joyce (1):
>   block: sed-opal: handle empty atoms when parsing response
> 
> [...]

Applied, thanks!

[1/1] block: sed-opal: handle empty atoms when parsing response
      (no commit info)

Best regards,
-- 
Jens Axboe



