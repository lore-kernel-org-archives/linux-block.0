Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749820F5DA
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004112; cv=none; b=QO6siK3w6drkhxF5Ylg6NSzCB8bj7VgwENvNqcXIWUrBbvcw+fcT/9R+aqNhi54fiumW6yDfYoFXWRtCOwiPT4Yqz3mDpdEhVw18sa50e6zJMzHI2LA9nYSCA13MgMEeG1RstcOiDA7/wLX11bC3iPcZ+cD5oYx/rIJno550X1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004112; c=relaxed/simple;
	bh=wC/oWyNcX/2qw/vu1KXDTflHxEgJiDzIcD0RLaEM3XE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BsSlX/TSak01aTnlidYT2HMJJOj3KRrP44/mtBibo4+GqbL8XdnUsJ/v3wZKQmaEPO3ivt0h861xSThyWpbIIp9tIkP+Jrc6+X4klvojLuyukOme8nRyrsf9uTGnveWKFA1Hwrn77PQfocf0qEy2PIM/ljO/iGTQ/j2Ltp90J9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=So5HkojA; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="So5HkojA"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ee53b30470so241222eaf.3
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731004109; x=1731608909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfkZ5vVPRthfg8DCWHf1TRm0P4AJoRMsICGEYROxCeA=;
        b=So5HkojAYk0W5gdaPquCXmAt4gqo3tLTF8uMlBgASG8/B7xMNSsHel5MvY1TysBh1n
         j0kiYudSKCJplwWIDFIVQLG1Ut2lYNfiHVjnMNjJ8AG4uRjkobzdzOAtxgy80vCCMImy
         rtKKwlEMax8vcgiyy4RiiDMtuqR34S0k3i2YQ3Bqu0jz+6OvhIojqsOF828Rb/xmI5+d
         0xITVzNrtEJNRlu2JkvmbckK4Xf67yozYaVfQqWsTkr+7q18XWB2o6VwW34VoxrpN8/B
         FWYUxKVTjC+gWFbE27y4azjU9eS6MPOL9KNLguf4RNfMqSaq3l536HBT2U5z3TsEkFsG
         FwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004109; x=1731608909;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfkZ5vVPRthfg8DCWHf1TRm0P4AJoRMsICGEYROxCeA=;
        b=s1aa6YjbO1FXOcgt1/Yde27NS3JVCALFP8pBtxQVw2FFVb9u1f7z5/Ga7uzDBLNKt+
         EQT5GOxSiUnOs0vD8dEJ3c6/pZLE0nyHLvxLEJEe/2rgtfalnsi1zfg+vE8odc/xF/E6
         nUT5yumIhLyzjNgQJsz1S0duOr5WuWlpy0S0PmNiuzFQGawqph69DKVTej62oSzJPOMP
         bR/1BNXQs61bAOKYf9k7xaZmKTeZTkVgGtBx+vy5DcqO8ewA7T9X70ahTPjpD2E7qWBb
         ud7vy8xhQs1gzeZP/SIDaVRDb4+nFRcUJK3QiM68QNgpCr+p2bFwQtrjOx2dt5jgBhlW
         dJ5Q==
X-Gm-Message-State: AOJu0Yx9KGC0qXOip828xnfw60wAZWDd5B5Hto//Xf2V5wJRdxDD9VsE
	GTMJQdRs6MUWM6Ql/Oem8UOT+WnFGTt9l21PDqP/BvupG6clByQLA9b9VuCBCsM=
X-Google-Smtp-Source: AGHT+IEaJbCM1Zp0ALVPFRY2YG9piHnZCsfYwBEzR/BBe3g7PcJVulRrLVG1fwQZgkFbGktMPTiiPA==
X-Received: by 2002:a05:6820:1f08:b0:5eb:c72e:e29c with SMTP id 006d021491bc7-5ee57d296eemr61006eaf.8.1731004109632;
        Thu, 07 Nov 2024 10:28:29 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee4970a150sm318578eaf.36.2024.11.07.10.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:28:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20241107065438.236348-1-dlemoal@kernel.org>
References: <20241107065438.236348-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: Switch to using refcount_t for zone write plugs
Message-Id: <173100410869.752525.9713906876157995574.b4-ty@kernel.dk>
Date: Thu, 07 Nov 2024 11:28:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 07 Nov 2024 15:54:38 +0900, Damien Le Moal wrote:
> Replace the raw atomic_t reference counting of zone write plugs with a
> refcount_t.  No functional changes.
> 
> 

Applied, thanks!

[1/1] block: Switch to using refcount_t for zone write plugs
      commit: 4122fef16b172f7c1838fcf74340268c86ed96db

Best regards,
-- 
Jens Axboe



