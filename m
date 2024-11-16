Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16B8BE8
	for <linux-block@vger.kernel.org>; Sat, 16 Nov 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771625; cv=none; b=eBkq5rN6eYKr3hTcCZ4fskzhwXHwEzgeEETIR+wI93sb1GPsRTcspIe1Kt7doZCPGx8O6851E1OXZkiAP6AcG3nvN0WmwB5ng/SPtNwWO7df75uXwQEAodACrkMeG1kPGLNaIQmJGD45QoRyMn1Cglg1UQnSq5sZ3FZ05ro2t1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771625; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=dlu0KiX2S2lpnMRdx7Bj+T+THqkME+mmr9BvM7ytbXRufogAmtC0pLYYn2WPVQxW8T4wbejQ2Ew+ceyeboa6IcQBKuXC7yxS9mh5lOLymz5aWQRe4f6H73CfuWupYa4xkflYBUq/8v+HiOW6U8/oEjC3M5liXrFZV60e6WAsqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpAYL5f/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpAYL5f/"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so499020a12.0
        for <linux-block@vger.kernel.org>; Sat, 16 Nov 2024 07:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771623; x=1732376423; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=BpAYL5f/pTdiB0iluHVsDPZd6BNtUIaqOKlOU0KQs44/YkfX9QTmSQakSPSRrBMZFo
         ynToHYnMKBKbV6Zci7TZOCwOaBAVylB7fm4fk67Z0cGoamUVFZyIJDrFGBTOWaGA1nhG
         yTlf4nWcrqm81VqWXUP0xrfmrPH2dsCmpDewf3dG7Xi9A+1DXdfzOTGJrsaeWOQ8d1Kz
         29H/5qAprI8BWEx3ZmUmWJ/q2PqBO6iwC+c7bcWOeoCwI2GOofhWQycbEMurA/HPLptL
         9Gi3ljK1uT6OzmM49DNRQzGlfqmKw2qB0Sg6SFwUdWUH7dsuDI+pDbunR0XFEclh0va3
         begg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771623; x=1732376423;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=fP2ey1+NS3hji2CWEj2U7gu16TTrq1Ely1zZqRb5c9IEB98r3M8u3trFHHTeKTA5LW
         s0GNiBxSpr5nLvaw4X3YGhW2u9cCLTsO3NimYmh/882x7lwoL+DuvGVlpmKowvzmDq8U
         iit798ug2MBt11vigA4zdb4fpV1kTAR6ZoPlCNa9Pbe7+X5KzcVt/kTfz2ferHQx2ZSk
         v4jdTQCH42VYzHSBO43Bf7V9PoABq8CUrAM9Lfh4j5naqOAP8ovRW6/EzSafr9e3EcK5
         t+LurTlNJIhZBGxDBESYor9FgIzcAd3kAwxS/9A5NGmudmLsfiRfvqK0YrTVPUgFZ79m
         sGNQ==
X-Gm-Message-State: AOJu0YyJuB+IbecCGyJwLggixyzONjONZcWCmFoZTgADQUPmeCefPlML
	lLvSfU+Il5Nd0EAs3Ufi/sSODapWyPsyBIikqO1SBWDTVPPuMlhnsnlO
X-Google-Smtp-Source: AGHT+IGlnRzGeciZ5lb8dydRTj7WUPSoLe7rvMZRmpyK0LHGRPrkcNkIVAYIsyYsKwvop97KkWvEDA==
X-Received: by 2002:a17:902:da92:b0:206:96ae:dc57 with SMTP id d9443c01a7336-211d0ecffccmr96754535ad.48.1731771623381;
        Sat, 16 Nov 2024 07:40:23 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f3698esm28770435ad.130.2024.11.16.07.40.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:23 -0800 (PST)
From: "Van. HR" <madinaradjabu911@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <12a80f411b2bfc4419d4dd9bcdba016c61b1eedd8654c30e939171fc6dcb9a0b@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-block@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:20 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.

