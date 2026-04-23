Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2F3DBD60
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916673; cv=none; b=cF6OBicTkZH3sFk+4ZCjb4kEdeP6jBvjTmRQcl0x6BWNSCOMHz7yD0vTYmKuacTt+2MLZDI7gwfNdgNdgcmp/3SVaKBWKQcElWmOKO79udHVqbNed5zJWarqjPGe+ZXGjO8a9vIAxXbYaEgZpTHbyydFzi87dc0QfK198pH8DQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916673; c=relaxed/simple;
	bh=sP8VwTVibgFh2Sp26u4FZsd/tmJ1zb+xee4pxb/MRMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGUS/vPzrrdurKngrUaHS7rBBUCh+HQY75XEBF3a4UoGUTcedKF9Zc4FNdMkIOSoSdcrv92yOVOKmDeHMjYxMuwnA0QobAuPne1moywAI/wXXtU5FWxsxEj1VsDyxzTCXkX4ReMjoicoHcEXtpNDcb5EmSb207bKgON+evwNjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXg2Bhtg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXg2Bhtg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so43689875e9.3
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 20:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776916670; x=1777521470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbrL1XZZhefhQUaVu+cW2ak3PDj8qOb0MiC1YKHdwbI=;
        b=bXg2BhtgkslZZLbmpnqmOl5evT5/Gy/gADyyVP07Wx1KQ+KiTke1xFJirkSfBL+4vR
         1HQigetdSFw8LK6JSEUx7anct7v81njKAjTW876p+yDE8HBFq1niU/AEU6hbZUx9hlRR
         KTAX+NnIvDlMK55qOr5M4EZ7IBU4L5+gbWP1dIOIahNb2nPbIsztgQmK8snnnw5kMWII
         15K83LafEC79lyCjPRYY7Wy71z4HFw9tB8pe+j8dbwrQO5t/iwjWPYLG1yXdbPNiUB5J
         ++sHg2Hys+tDMp+sABQbyCUWkQZb7qPKZrbrXKHN7nUz/0kxblihcv5TeFQg2vz9+Va5
         toww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916670; x=1777521470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbrL1XZZhefhQUaVu+cW2ak3PDj8qOb0MiC1YKHdwbI=;
        b=d9Ic/TMaft1yRdIqIwlJS1FWj9NpTtEM0Otk/HwGfbCG4kG+gomLALKbuHF9J0Ghc1
         xH3a6W9r+UcgqTNCHC0jw29IjTzj7I0RG4xU+co7Ay7FkoPC6f0L3VI/tv1DLbTQDlfe
         OLSOYgeAF5/nCf1vE5gh2Vch/+xxPA6PT5d9pBaOudQZBRxUste1WSyjUzVgD+pO1Msf
         N0e3gn6J/mEWhWFR3YSw3mdUQZejwTn8OoPauZyXQeVmhJxTLJXJmeM5NXR1VcuGXU+s
         A9jqrGLl3AybkcIhfweIFDwz45DYuVC7pCT4ZCqQfA9gQCBAKa5kvaQd2UZ3AhG1DtLq
         pO/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+cUQuOo/WYIunaT3ZSH+9xMl0Ce/2torjMK/itbFOvTyNt+azzlx5qP0XSvDAeb59XHT0X0wI02zgtTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0eaAgUn8ZeiA1XNDDhVrw0BLgpet8eejd6X7wzoqsrd1c/X7d
	KONXaU/ee839ig6w2wlQYKo4VWJeEpNQf/bhG0WVEPWMIxntcyJ3EtlK
X-Gm-Gg: AeBDieueSD+nDQevo/AdrxMlr84h479Dy+0toOlQT0yiGjbANmLJ3YypdMs7COQ94Gw
	HtIUb5oV6vD7VnPIG0aaE5A1iO/Wa8O4d3CALcvUOMP6Zbq/fSJ9yj7aUj0fjHzRo9qd+OYBjuX
	BKaHI752P+lRNvergRp/rbgOm8eYGA6Qz0zFCf26jVA3LouX/rsqqEEUCFy9gruf3+eayyypXGk
	TEGsDWqm9Ns2NE5X5rzGNcV3I3kxGaFzrtgW4Ejo3lWQbEbW3euNoMldnjflMDegctVl31X9hpL
	E+mlPbSHfg3yua/UghCQA/JU2np7R+2Vsp9RrQRPxCxqRBiSXW9gpBoCjTns8pZXmoEb7jNj4yZ
	pKIPJFAKYbXzP0ASio8lD7NC6PTsEre0lns1TUETwpXJmZiqdHOqC8YCxyNU0b8BGuFATJion8d
	1rcD79MFqtwUCZMeph4EwE+hSJ9z55zr3Op7uzlo0eIsVeU10y3Kha+EGG21KDbfM3RbcX2Zbl5
	r8ezyVX8udrUSZatCo=
X-Received: by 2002:a05:600d:8451:b0:48a:599a:36fe with SMTP id 5b1f17b1804b1-48a599a4413mr69411735e9.24.1776916670290;
        Wed, 22 Apr 2026 20:57:50 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm836912545e9.3.2026.04.22.20.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 20:57:49 -0700 (PDT)
Date: Thu, 23 Apr 2026 11:57:44 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: ublk: add ublk auto integrity test
Message-ID: <aemYuKH5wlOFhMX8@fedora>
References: <20260421200901.1528842-1-csander@purestorage.com>
 <20260421200901.1528842-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421200901.1528842-4-csander@purestorage.com>

On Tue, Apr 21, 2026 at 02:09:01PM -0600, Caleb Sander Mateos wrote:
> The end-to-end integrity ublk selftest test_integrity_02 requires a
> relatively recent fio version to support I/O with integrity buffers. Add
> a version test_integrity_03 that uses the block layer's auto integrity
> path instead. The auto integrity code doesn't check the application tag,
> and doesn't indicate the bad guard/ref tag (just returns EILSEQ). But
> it's a good smoke-test of the ublk integrity code and provides coverage
> of the auto integrity path as well.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
