Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472A2253EC
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661096; cv=none; b=p3y5UOC+6N5nQStzmsy2qi/YJcOCvMweTgEGnkeNwWkBHiKtuiWTmX9wKuLY57XULA1YQD5DRvDF/4gAOqiE57jIaBVkQFyhTWbPNql3zCTfXI7VNy2QG14fNoPJ9Wy6L7tD365iIl9f0brXg1ZxAFUO3t25G2w9ArEc2qSH3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661096; c=relaxed/simple;
	bh=C7WOnO6ID4LqxTasOYmRz/f/EOUiS1sTWpJj01SHmZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0E4MCndkvYdrbrHB9wjFC3+Y4oTHXOkaS4YCUEpt+9yE02OvPysWQgb7ZpaE1ujp4pF49LRq71ZlVHlM0v7L2PssGFakj8iKSp2Y2SufcItRiFNIisqo14TEH36MMg5nxbq4JVw9uD72XzaLVE8mVp1/hHO86/vKcLUzC9ol3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Pw9gKtRb; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Pw9gKtRb"
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-65e8c8831f4so7290eaf.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661091; x=1768265891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bEkLGAxkvhhHV6OBGkQMN8FAiPS5rx2ziWg20da5Ww=;
        b=Pw9gKtRbEcNvLZ9M2gdnR/rFsJICU9bctaHwYi/qb4qAUecD8D5diL2qS9EUq8DWZd
         nNyp5LLUGBlur0+eszz8Fp6NOYvvAWK3yHlre497PXKF4oT5nCInNOmuGPG0Qb1hYy8j
         GNGq3CaIehBPJ943kOnTPrR0rK9ZdZ5Afrv4DMtYzK8MM/fAFXCI83XjS6RoVKZWvWjL
         CiVapZayTw14ySQ6hZFM7XW+Quq1oXVIqGP6zNAAz2L+9sJ3l3y8DZqwmnv+dLn5oV7E
         +DJb5BZDc8181/rdSnplkCmnK5zAjsJGrvXIYFjcdDPfXn3smC3wvzcg1NbdjT1Eto0s
         AjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661091; x=1768265891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bEkLGAxkvhhHV6OBGkQMN8FAiPS5rx2ziWg20da5Ww=;
        b=ixZj38CWuWE4EgcwWK741cmGf2Jbkmni/e2j62mOfHFjiB5gPxM2T+YnTq3QtRN2pc
         2Gniy9mOK54ZCLr/zFaG6nDye3QZ8G1leURpwJhidKY+2onebFSP4ognlAkGuyyu5W/2
         GLxcLTcPot8/UlsvQdz+XMP/zAlmkDzCM7nlTJ5r/6n6JS/VFJGhL/NRwJZVOI0yd4mp
         xbJ2SKnXyVCblVUVPXBp8TiFlmvu2guLuKSSnoyipVpsKQjCwFVJTcMyfmw5fVI+xYTU
         5Io861jTpD2eSRWzXfn/AWKvMsiEsGzbCUmXSdIyiUOHoocu/BZjJrgVGj8Tj4KR8yuU
         KVxA==
X-Gm-Message-State: AOJu0Yxyl7qRjSuXRVtf+N99xH0alZuoga1ajwFgEbyv2LoqFDr8EUfX
	kh/uXF4YBao98olz7v0GHsHeonM0c7yMnah5AgxaARFADwunnwTTthZ9thfBb8OkOlb23NPplCH
	zQHEShmR3lMpIREV29Ex7x+5tbMKm3veGuUXA9wFiP7UJcR+Rj78K
X-Gm-Gg: AY/fxX6asrqXIJl+JoQo/7DH7qn2Xg/+pQIIAPQZFjoWHd+ldHhpG17HGAkp0kNo80Z
	OdftasPtdMkHbIuQaYN73zMr9GnkjQ/+J1BHq2JSfI+GoZYPA5uTCqP1l+kkmETvEoubNlntuPK
	LYmL5lzABTLk1iS8L79SCr7KqZZ4BQ2qO/f5rQZx+vwPQOTHlE4s3oM7/V9n6V3WrFAjPjKl3DM
	2X2fgVKK3g0euTz9Yk1nLkkSucirxoaGrcFLhZIwgld4ijp9RydElcfwZOSVDfHHG4MWOearfSS
	3cw9FJet+R4PGjsXzAsj96vUsN85piLKYRigKPdjWxh12F8tl1ptgV0xmUj+WB1GgZaub3heenu
	EexvnGTQJCHtHZNFOi1iZlJBdrVw=
X-Google-Smtp-Source: AGHT+IFG8Io995j2dSJYPSJmiBupcP810PQCJoAnia5A/MggoC25scMJzZR56R+YMLt056CG0G4W8kcI28h3
X-Received: by 2002:a05:6820:6601:b0:654:f5aa:7434 with SMTP id 006d021491bc7-65f479fd91dmr439065eaf.1.1767661090901;
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-65f48d05533sm12250eaf.7.2026.01.05.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2F7C3340960;
	Mon,  5 Jan 2026 17:58:10 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2103AE44554; Mon,  5 Jan 2026 17:58:10 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 12/19] selftests: ublk: display UBLK_F_INTEGRITY support
Date: Mon,  5 Jan 2026 17:57:44 -0700
Message-ID: <20260106005752.3784925-13-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for printing the UBLK_F_INTEGRITY feature flag in the
human-readable kublk features output.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 185ba553686a..261095f19c93 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1452,10 +1452,11 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_UPDATE_SIZE),
 		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
+		FEAT_NAME(UBLK_F_INTEGRITY),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
 	int ret;
 
-- 
2.45.2

