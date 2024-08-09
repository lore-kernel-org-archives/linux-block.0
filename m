Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B3194A5C
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208863; cv=none; b=CJn1EetNxSVVlsnovjw0rA1FGjZjuLsd82WjJR67QyZACeVCyjyXiBMbj0QHvd163zq3mpeN68gYI+c9YqRrfgDet+dzsv9ByrCkN655W2Us6Zsh9hW2a6hOydaUWODO7bH/0+esAZzdu6xCVWboliLkPtLH/Cqa+GEtWG3cQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208863; c=relaxed/simple;
	bh=kCFVoFCFuy0U30o31BMxvy7Ab0XDZIvqSHyEB+oQ4CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AI/UKF6wKz3cgCJ3UPaZ8S3zbkQDRupU5lQtirqFUlMd/kWqmE4OYZZ+qCtWmnE46uZGZIvXSXmZPIomiX8H6i0QIa3FOj1qaMEoaovmvm6u5PWAi9fekH0im8ST/6eMm/WBN0y1OaV4LBrvphuAhdLBkEjiwJHgrU694VXWHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sWx5JMoU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sWx5JMoU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cd16900ec5so368466a91.3
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2024 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723208861; x=1723813661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThAFzPMUuQHD9VLFPcfFOW6T/XOpVMlWLGK4CG7KhUc=;
        b=sWx5JMoUrEXTmPDiP6frb30Bgv47n39B9+cDu2l5M1jIpxCppBDOqzF86XdUU8/yCb
         xl+J53PYMKqQLBuYmSv636vgSXmIBkdSf/o2r8mfWffDNWM+ZK9+K0qX7tUNyT00ZD1Z
         kAVe6M6qDdrGeRu+EjzqQRwvV7fDnZCCqABtz4XgxTftKMuAFicHKAs5kZFb7IR1btB8
         q20WqFSk8ebG2uqhNL9ySAwLg2FO16D2f16EbgtXaATeYja3pDwdFEz+saN47xZsDaGe
         hJChZdUxp0g05UwY7JWMt60Ii6ejXwE1kV4d1GzRYliejubDTDCqHpU+RZI1ioOz/VRu
         JI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723208861; x=1723813661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThAFzPMUuQHD9VLFPcfFOW6T/XOpVMlWLGK4CG7KhUc=;
        b=pC2p+zzkWaY4cNSQl1p7VB+iqzAW9j5UwSY+YNZnHM+ByD6LS9x2qQVtHXF801OSYH
         zUd+uRq416zcSDkJl3QekJNxOsrMGtCR1b9w/hzQlF9BGVZybuew8jvU8trfBGmp01iu
         7a9ElLVfIc006ai2d0fh4mjWB1G2RTrCI9oLbCoS5Ga6RJftg5g3zKaVq0ZBDFkRXgKu
         2b/Q6q7bpW4Goi/RlFdVcm8eyoxKg0nalN3uACSWfucVM2lp6HLL7LEKNhY7AOGiCE8R
         VWukzT1lDefkfYswcjHjC2XSc0KozQnckWyYUh1Btt+l+hepnbtdKaMAPLFA9gk6EPva
         j3fA==
X-Gm-Message-State: AOJu0Yws8K2vPQsBMI6QTgIhFIpzoeviftqJQnk+yllVKtIg5fCQP8IM
	jMsot3f7Tg3daV7QXBbybMDkPt2n4swp9XuWktRDpy0fUP/bxsHa6Nd95v+lC9I=
X-Google-Smtp-Source: AGHT+IG/sFw9tqM0pOt5/pXk9bnpnz3hLNgW6nFzjVujbZLZQ4Vzu051dTL4L9BrTEGMcHavnDGmNw==
X-Received: by 2002:a17:90b:224b:b0:2c8:4623:66cd with SMTP id 98e67ed59e1d1-2d1e7fa2c8bmr901226a91.1.1723208860658;
        Fri, 09 Aug 2024 06:07:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3ab3baesm5285151a91.15.2024.08.09.06.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 06:07:40 -0700 (PDT)
Message-ID: <975158d8-4f26-4b5c-9cc7-eec15d901eb6@kernel.dk>
Date: Fri, 9 Aug 2024 07:07:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: sort includes in bindings_helper.h
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240809064222.3527881-1-aliceryhl@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240809064222.3527881-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/24 12:42 AM, Alice Ryhl wrote:
> Dash has ascii value 45 and underscore has ascii value 95, so to
> correctly sort the includes, the underscore should be last.

This commit message lacks an explanation for why the change is
being done. Yes it states that it brings the headers in ascii
sort order, but WHY?

-- 
Jens Axboe


