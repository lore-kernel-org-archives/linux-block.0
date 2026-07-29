Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F23EC804
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337164; cv=none; b=JCpNfCjIqZdOt8uiTNrk4iB6/+aSoA2xTp5Tb1LIoyjGgbIp4H8jj4R2wnEI0ZWLw7HleFf3oGW7FAdXlMa0SZgx6sSczYrmZNWcRmNaDYxxTar/db0/wKDzN9FknikOWFsfg1Pz27ON0suqw8Aee/iM6n3rXWm6UZ1e8M+LiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337164; c=relaxed/simple;
	bh=sWl32zTJFeCBg3bMlzNPgUaWc/Ady7nuTuFxZlRtjyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khdo8/5XfA7RXrsKIaXDazKGxguGrMuLkwDzT9pS4ybiN1HmYG2y4TNlJUVsJeJqWqKkz4Dn5NHJHiOdxYYomaEpyHrouPGqS5B6kb1sPrOQTqNHbcIyvMsinYE/BPZYAjvWkf7iGYAPNiNwBjPLtDVlCb1XSAtdVakQQ9FpNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWHUaaqp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWHUaaqp"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e69a2db34so16818217b3.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785337162; x=1785941962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4aOKXhQWoqK5Knbl+TGoyEtBf/oQ3xbn/F4o+A0jhk=;
        b=FWHUaaqp91yo/8Bo+BeTAD37MrGsmEN87ILQfNzR8UlXk96PigUWWadgVrPGA0jTeZ
         icTgUbFIx7Xd5Bs5rkX6qWc8EizosktTuQcWCpxXvn1JmmUAIxjW0gtQvs8S3sq+S6Tw
         oA/DxXnavHklBDfWmEz98lew0ybzILej+p88bX6ybMhoIBNHaGAat5D7k3XxZOlKgq48
         +oczXanOVcerR6VlKXknwehYeJtw+YX5kMyqbs99taoHOiwQFkpekeQAaGjiYu5ZK9MA
         K/XX/jj2JuzlpfeKixj/SnB4bswLGOx89PO6iN1L4sD7eI0MwWjpP+FZLWwRnEqlbKzA
         kMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337162; x=1785941962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4aOKXhQWoqK5Knbl+TGoyEtBf/oQ3xbn/F4o+A0jhk=;
        b=eWz4NdKZ40Ai2KdenxqqafyR7CNQ3HZ3jDNr8yzB/ee7zpADFSdqt4SLLttCKtKU9P
         AR9m9oVrlI6ZLKUHbzt32SvYnZw+c2+9PJ0s/jw/Ywk9rnsddNH2EScnnac6G+Cy6wOQ
         oTgoiSVEJmJt3gYezewQxkY9f0rmkHgZfZAku4Lz7w0S7gxzjscnI5YriD92KB3lTDcl
         4TCwi2+3bTCyJlK3gF63GjcrN7D2ZgGPQtF5Fvi7gifvlXCV8j34ejakC2/i509CMEqQ
         bzHrngkKg5ixtd5yloClZO5bT/whQOJdlsTG0V80cYB27GRZlOFaPMUhhYcPc6GvEGs1
         7ikA==
X-Forwarded-Encrypted: i=1; AHgh+RoUuNZqUaCUOYTLjrovah67qoKRP5GahqxA6WG/TsHKoQHEprE8oAlnVSzSUQJwgvp3kl3tKLP4XNXKNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNHLRF7UtRe2Z47knKhyJcXXizLFIxGoH9uzvKB4JHzxCb+X+
	1/BZRCCNWcbaouqPPJz3O0Pi7WJmEh+Zaak8S7mt+5iaZGfOp05VyDHn
X-Gm-Gg: AR+sD11oeg1xib2h23sRLluuspDV8RrUbNwMptSpq+W5MVKjg9KGgAsIIaUxn7Tt723
	/Zag85YH3dYhW1Kp03s4Wck/2DL7spdFil5rLsofirqyZbL9UKbrAeLFxadhXisARR+ZRMWhHwD
	YEbCJ1E1f4W72fgWgsmRsfv3/nIW0ViP2kbXmJ8PxWfuhpY1tF7xB3OMFQJaok3C9SH25McRDxT
	xr82Pj/Yg/uPW5Dyjj5M0VRo4MwT6xzXnvI+gNpyI6V5ljovcxInZzREyAmxOLhW0un7CioI7gk
	GJPyXjWq62MGDisLMiUJvEM7+/8MV3XOfiPt0IrF2+GZsdt82IWC0VfV1tn7ww2kTuBSJ3HK/pA
	jtxZerdfibIOyhV43jEs/SNWc1KUo8Z5azdusXqZjqROxatYpsimWOKfgMzH6r6oPGfAU46V+0B
	rj2Mmv1xC0yw018xfBJz3wXYa7QfuyPWBwHJT7GPWLk2KEj+OKjcZ2wofHk9Sc1MD9TeXh4oxsZ
	56aem5iiuUK6dWpgEPL9RHNnpiOgsOrUZtZi5vpm04YCAQYxSdwbvcLS4cwTjeHElabhFevKbfY
	wiE=
X-Received: by 2002:a05:690c:6a86:b0:81e:bb95:653 with SMTP id 00721157ae682-81f99362697mr37481827b3.42.1785337161514;
        Wed, 29 Jul 2026 07:59:21 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa2929654sm18963107b3.32.2026.07.29.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:59:21 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:58:59 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] ublk: remove struct ublk_zoned_report_desc's
 operation field
Message-ID: <amoVMxsBRS5_ZDLb@fedora-laptop>
References: <20260729012951.3744582-1-csander@purestorage.com>
 <20260729012951.3744582-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729012951.3744582-3-csander@purestorage.com>

On Tue, Jul 28, 2026 at 07:29:47PM -0600, Caleb Sander Mateos wrote:
> struct ublk_zoned_report_desc's operation field is only ever set to
> UBLK_IO_OP_REPORT_ZONES, so remove it. Replace its one load with the
> constant.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
