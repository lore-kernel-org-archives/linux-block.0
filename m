Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB43019BA
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171604; cv=none; b=tajKNvnPGWzT2JQzMQ7V2V8hAiGwumQOm3UmqJDfZ52wSaVUntUGPbE9die/bW8YXK9n63qzXJNoF+AEocHayCRLxa/ya+31MMOEVkdgK3+L3ZgzkWZM/vecyt9qCL9C3hKGFlc1LigX3gTzioTjyGwZEr4uOHPjzpRNuy1ZWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171604; c=relaxed/simple;
	bh=aWg0OUksfLLBTM718Uypj0XbfdSL2DygqbUMQjndRxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qkm42ho5UejhY6zSd/A1AjW4gx26Gv6MU1C2U6thc7erIAoc5pdGYjb91qQ/kvCLvBIEkBA9k74RtVIQj6Ldwa0UOtJp5TBEjj+IJ0Q6CXiEHPUvve0glgpYtkKnub17t/TnWa98NNMGtQPEMv09egSO3txPnw7d5z3GWXHnPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCB/yADR; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCB/yADR"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ec6188so4362895ad.3
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171602; x=1790776402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEgLSFj1Jyzae8Gv+oqdmPoAbEVAiNn+0UlMSLjIzD8=;
        b=tCB/yADRtxuRcZUUaZL0HQp5UmCsADhlgZgwd/PkrJZlLAk1ASCXttoIhB1WSlw23y
         7465MCC/wFGn9/fXS4yib5C75JRbtlL7rlEgyuoAoZxaoNXFGUrBAzW3VRxTxtvQfbAF
         xZVKjlifsU1Kb2GsuwGREpnjEgmBeYtmETNFxcS3lDO32AaCyDx8sSZ5VCjmedw9s2he
         RYJ6L0/hAkFLWLPeEldHkWASC4H4IF6i/nqTjnNPQEAnEGOpZVidRVH5ffU/nbdo8epK
         HSQC5lLFDWR7SulizgT5cwYcJcnrJYOSKhou7XPVPdxyjvpXYDwGffSLynWjL9AsCXwb
         VOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171602; x=1790776402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JEgLSFj1Jyzae8Gv+oqdmPoAbEVAiNn+0UlMSLjIzD8=;
        b=o/Huoxh/ctdmLVBge/Jh4AQm4KktlrdzFgvbbPFasuoSm5GXheFdxEnJMhIY/tXdko
         xkcON2GmN4F3wtiOHKIdaHcOz0GV7r/Jm+8Cv3sAAPuaexklwlDCDDkSDhmAKrRRxTWW
         hn4Rid9AJuL3FESd2nQd56RFjVupzI4D20KiN8g/tG+C9NtaH2i4j9aAqudOahYkoAyl
         2jQLt0e0ND+mHsLOrV3HRE2muT8XexXYJ256FUrckyJkZxtk2Anyo8c2O7KxKcXesVsU
         ETuleFdgJ0PmjXxIrPiiSgXibzaoiJAlVOiG+QW35QaBqy0dBg3aoud4SEJAOSEFz51x
         ADwA==
X-Gm-Message-State: AFuF++n4lJ8Uvp0l4rTN42FwdPS/7nuR9fPszhJQS30cbDyHyXGcCvSq
	EU0AOgJsyLt/Gp293BFtQkjh1cEBBEODVfCmGwgqOB2MH0K10TVnEdqD
X-Gm-Gg: AYBFou38zmUWkcJnPgTIludVM1P23Ltc9ELSp5d7Zad0xLXFgcvvN8zWLnvm+2W1N3a
	FxN7idEhlBxE9u9Zoxfau86w7AICc6EY2DqdqONQQlTTzOxvkWXRQS+LMDd+hkDjRVG0Gg/Xdy1
	nHtQ27BSUmyMDwIwE5PgcQsBR/nNhbKfBTQ+clJ6Ry9j0ErbAMYn5N/fKcaSwtnzDEybSZcD6Bh
	ZZElT0CJDTDzuIZrw0+iUoH4JguyUG72ZVPzGe+Fp3RbATYm0RU5GlZBbMiIjldb7Kg2ApvAqsX
	TGTH/3waOWof8/lQ3Z6Gx/yUq3OzT0n/okE8Gx0Q9/yRoQ4c0abxX5ke+bvP1rESn8mKYVu89mJ
	tQLlqxVwn06XnxVSU02Pg3y6WUWz/DoCRvUThrgr9Vs/Zwl5I1o5qid/uWu5I4uugb5b9qEdLcm
	hOundk5R4a5k923CkZucz9MMwk3wex9KulV5s5aJYanBPfqQLQa1yPYRGtRTAMZRkU7BP+AMzta
	8qb4OWdk5MCNHYKCuUiDgIUpaw=
X-Received: by 2002:a17:902:ec8d:b0:2dd:c100:424b with SMTP id d9443c01a7336-2df69de9aeemr24338955ad.47.1790171602285;
        Wed, 23 Sep 2026 06:53:22 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:f072:2258:ced5:5d8c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5d738bsm11494825ad.47.2026.09.23.06.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:53:21 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests] nvme/071: add a test for fcloop LS request use-after-free
Date: Wed, 23 Sep 2026 20:53:16 +0700
Message-ID: <20260923135316.13144-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arOLaz8NSnz6bqL2@shinmob>
References: <arOLaz8NSnz6bqL2@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shin'ichiro,

Thanks for testing and the review, v2 is sent:

  [PATCH blktests v2] nvme/071: add a test for fcloop LS request use-after-free
  Message-ID: <20260923134938.12673-1-ngocthang2710.1999@gmail.com>

- Noted the kernel fix's commit title in the file header, since it's not
  applied yet and has no hash.
- local -a ports, and use _get_fc_host_port() instead of reading
  ports_to_hosts directly.
- On the hang: I couldn't reproduce a real hang, but I think I found the
  cause. _nvme_connect_subsys() doesn't pass --ctrl-loss-tmo, so it
  defaults to NVMF_DEF_CTRL_LOSS_TMO (600s). After we pull the remote
  port the host has nothing to reconnect to, and the following
  _nvme_disconnect_subsys() has to wait on that reconnect state before
  it can remove the controller, up to 10 minutes if it lands there.
  v2 connects with --ctrl-loss-tmo 0 so the host gives up on the first
  failed reconnect instead. Let me know if you still see it hang with
  this.
- On the swept delay: I tried a fixed "sleep 0" here too and got the
  same KASAN UAF + list_debug BUG as with the sweep, so it wasn't
  earning its complexity. Dropped it in v2.

Thanks,
Thang
