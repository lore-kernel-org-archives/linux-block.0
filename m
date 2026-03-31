Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF6146A66
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940558; cv=none; b=IhHidS6nnMMA6wccu0SJueG055xDNlqQKod0ztzpUdTLg48eoCrYCNwSInSoq3SO46pvkslkyEitIIqVwbgyI+5ey4Dodr0ybP4telAeQfuZEozrHXahU0cDv3QPpB13ZwxtBoqOuD6KQRFbvZ+RqJSGF5RmJ1oio/sjhdc4VwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940558; c=relaxed/simple;
	bh=vfsfPTAFa+cjfR+3AJsOAX51DLByk6M5kVtNWODXYtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r70zU/XegCCvV730lzx16KFAn8SjKcG+yE/DWAth1KP/PBYM9JVPygqgCIAlLuO9Pun20e2x2Iu4cj/PbirCbB+CU4bEPAlkuKinlvJiF4TtAMe8RqlAO5G6fV2JZ8hM6wGsVHt+OTalUgF3DeSzNnmC+LTKRJjzW9y5pI9ZCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YBEah2FB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YBEah2FB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c4b5dfe6cso2413032b3a.2
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774940557; x=1775545357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3Es0Jq2Oqy/D3XNICPyfENzALak9AF3Vg+PltBwZmY=;
        b=YBEah2FB20zapO4U1MFK4dt/8JCwTu5aF1PN9EsHOmVxq7tQtrJoB2vNMKxeuXSoxh
         W4woFlh7xqF5K4lDpH5DWbPZCQAEqztYRFPxcE5MHNo4wI7XqMFNRlx0Wbz1KGVTBx3j
         2YWzkor+kOeUinr8uT0EKFMfI3JfmIzauKJg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774940557; x=1775545357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3Es0Jq2Oqy/D3XNICPyfENzALak9AF3Vg+PltBwZmY=;
        b=Ql0b6Ip39A/HJZjlJ/j8eQQmnQLbHG6Szqg5CAyi14/dVmrG223tvCMtRmHD1IAlqB
         XmDnmfQD7n5omJCrSM263BqqNBB5k/057F4pZEJ1uDdMnWTYoo110lzH5KOdV2iBeKzv
         TQQPOLmOYjKgv0BRgJWhNFzi0CWgrvcMp5d/AmqAcZDD8/eNVGFTkhWBzYRtYxYvY5/G
         hMW/tpUxhefsbVhFQEqxBRa/9sF1gc/r97OQFD9mh6mStzso5B3cNbJdLT/cZBotN4Dh
         hjcsAseBgjdUHLo08GMLjeNq2VwIKtMIi29ozGfxneOOR4XRGwjhS/7Gx2mTJioworbz
         yqWg==
X-Gm-Message-State: AOJu0YzYj0JlCA9M6SyZlG5M9U5aVLlfhUHlrIQkgQKLgKfEOr859D9x
	XuOwVYhmAd/9gYHJpuFsdof61K5T+OtN19wEf+y2l08P+UnEJZVaawJP1MKWbTFY6A==
X-Gm-Gg: ATEYQzziXB9j/5Vk0siORmEraXAvXkMYBFmVW+Zf81WaM2VhRm9yKGcnS8UiHaoKSTa
	0+GdBKQZQ30iGJ05vsOrLT5KhkqvPm1u+9XGExqQBN3DZ4sZOOMKI2COQJu5OvkxI84AAYK6E7d
	H1v2W1v1HMXgxuvJEuN8gRXf8SdD5aSUmPjAQM7BVD3mw1BJzYwoS4z9fovI4gx2vJHTVpGauj0
	nZUEttpuH6vdqRPIcS/JmILzbbBEOF/n8gA6xX2dTqFuNbXSi9LHIFbVb1g6F5ynbIRZuvrHJgO
	PLCXSRvrS+WsNucB/DtDa5ZEZ2BR4LEAcTHJKZhTo7VGVYIifEaA8whMhqS1qaItZRO03UMa/up
	qho/QOjdjt5hvSCbmXWL/CTHr+2WFFly6FpohJaLXK+3C+YF15UIOYB3b/nqr1tbZjztswv/V+M
	rjFoLSWCFu2SAssdfLW8T4QNYc/36ZZnz2arzhrJXDGtHfX3x5vNSABXChR8XH9lE=
X-Received: by 2002:a05:6a00:b486:b0:82a:7734:8c6a with SMTP id d2e1a72fcca58-82c960a484emr14265866b3a.48.1774940556821;
        Tue, 31 Mar 2026 00:02:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:90ef:61f3:1679:56f5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cdd04bb0esm865819b3a.38.2026.03.31.00.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:02:36 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:02:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Qu Wenruo <wqu@suse.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	minchan@kernel.org, senozhatsky@chromium.org
Subject: Re: Super slow subpage IO on zram block devices?
Message-ID: <actwaS1SyKq4ERSp@google.com>
References: <92361cd3-fb8b-482e-bc89-15ff1acb9a59@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92361cd3-fb8b-482e-bc89-15ff1acb9a59@suse.com>

On (26/03/31 16:15), Qu Wenruo wrote:
>  # time blkdiscard -p 4k /dev/zram0
>  [ It takes too long time that exceed my patient ]

It's not you, I bet no one has this much patience, because that's
basically a "deadlock".

I'll send a patch quickly.  Thanks for the report.
