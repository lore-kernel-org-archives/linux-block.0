Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C81361BC
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739326; cv=none; b=chkaLnW8kjWoGwDc7U2YwcdC8+HDWDOz8FWvKpn9vQI3napkpMx6//SFDyczCtJOwXRRoFd5ag9nQZbHPgjUd0udtIRHhOx7bCftcUPXPnOqj50w3KwEpIEuYrvUcCK6aV2cXp0AGkyA0uYmw8OC1C3yLAG2fSsoUGhyQs8DF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739326; c=relaxed/simple;
	bh=5giwwAVs8T7QluRTB+xOQJkMr0YaoDj/v7XSb1HRsYI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qlpYA0w7lLyrvWV0v9HHAer+u9loWq68VlPuqEpHPITBxyz4CX+73IKpbOVxNm4a4xKyuT17owlmvR2scf3kRmw3om//5dZzORu44N4rQzXNJ68BR1Hro4SL2Gu+bULT+qwOvGCbW1/bbmGk9vNgHc1WTwI2w2xszYgWHIZhnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ThK34fz8; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ThK34fz8"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so82841739f.0
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 07:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739324; x=1710344124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g8A9vGT3dh/Tnjptv4r4bg2myLV+zLGVtLq9Wt7KFM=;
        b=ThK34fz8KYi9hOVVCoX5WC40bBe9o5BM945uU0sSLq2acRjhPQYIwxS2gcXsG4F4eR
         i2Z65L2Ug5qyHth/gxsvUF4uosyiCbxOrXD7g3zWeWPuiolrTBInv2xW/VxxAlxAakZt
         XrTO8FWgmox8c7Q/o5KZas20VEll4j5ENBy59bL/pXY4ijtmAJyEYIP9LT1WanfVFzz9
         Oss8xl0DHsN59EXVwBO3PHxdqeJl/QqmoKCsB2GgJKuMA9KM8uw9b9WGnM8jDo+jJkUC
         D3x9NOZ9kcgJj0YHEo5qPRCASJbFRb4TGykpqTymT1qXvMhsKmBtbcgxUwINnCK4s11a
         1A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739324; x=1710344124;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4g8A9vGT3dh/Tnjptv4r4bg2myLV+zLGVtLq9Wt7KFM=;
        b=vi65oc+kblf9jA09hJI9hfEIBhdR3lXQdHtpaufotF+7ulUl8eL3kQ8I/j2yiMX+Nw
         BEPQwwTCgQvL8nq0qhAKCmfJKLjWhOCGAXFi+ESr7BjYb3po14mnv6QtggLxwVIhCZMl
         BCo2ukwys2Ii6w5a8MXskn8VNS8qUaLEHV093nhQqOpUv13zoCLhOBe29jS1Twi10jok
         DxED7vCoxafO1quJcpdr899q93YUj5avUjEUSeaJ1qk7+FmugbaFEvQkw7u9rDIMyBGP
         PMD1CE5i0Oj+f+4RUK52kaDpwyR842OJ3JLI/9lE1nKq7UC3aL4MvKbVgmZ3V+0ysWhj
         0kOQ==
X-Gm-Message-State: AOJu0Yz5rwqfXuiupBNGnedl9el0g1jDLcXYXGOi5vxGqoI6SbK/YTGR
	lkCEWQRp44R6ou/3KaggVS+7OViTFWnJGJkC1V9ISOpX6yqHYaGoEeI93xBFttYBYJGaFilnlXK
	+
X-Google-Smtp-Source: AGHT+IFfwCUfMFiQah0je1TNZa8DbUgEvbi6wVSHkiMMkU6phaMDwuj9KIibMdJlRYTFwBqyREQ7nA==
X-Received: by 2002:a92:ca0b:0:b0:365:25a2:1896 with SMTP id j11-20020a92ca0b000000b0036525a21896mr3696110ils.0.1709739324728;
        Wed, 06 Mar 2024 07:35:24 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: jonathan.derrick@linux.dev, Li zeming <zeming@nfschina.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240306100216.69340-1-zeming@nfschina.com>
References: <20240306100216.69340-1-zeming@nfschina.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_sed-opal=3A_Remove_unnecessary_=E2?=
 =?utf-8?q?=80=980=E2=80=99_values_from_err?=
Message-Id: <170973932405.23995.1005180827192138454.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 06 Mar 2024 18:02:16 +0800, Li zeming wrote:
> err is assigned first, so it does not need to initialize the assignment.
> 
> 

Applied, thanks!

[1/1] sed-opal: Remove unnecessary ‘0’ values from err
      commit: 217fcc48074be4f526190675140a478ee795d90d

Best regards,
-- 
Jens Axboe



