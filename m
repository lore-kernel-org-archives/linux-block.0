Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC333121B
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938872; cv=none; b=j64EANW9TRu+eYet2ua/1Q2TNJgg4rFqSDZPbdOPf7y8SKV6FmLfKWLe1tEQ/5vrOSMWtnL/03mK5ob2EuDFCv1KQhp5DY0o0pa6yeSsTSdYMTfm453BgJRdn+mLhcf/hQU8eGRnMNjl9tw3ywRy2QUkax9LkJMJn7MNywRheI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938872; c=relaxed/simple;
	bh=Kk3j5wi5kjh5Cxewa5Hl8dP3E36E91kc7BaAfADs2eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWV18Yo5KK3BExEmRhaanviQ4GhB44J3Zq5oQWfRtQojLMDOUB4ftrvwnSV+fbkvp7uybYUzOIiuL3GHxDVsMNgFDLXp3dd6HoDwGVLycKmbLPukb3uRCYtnU3ph4tnuCVtPHlKBdEWBIuvePZBt1pXdtCvyu7PhXu1KSQoe/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CK913crW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CK913crW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42e2e6aa22fso1072160f8f.2
        for <linux-block@vger.kernel.org>; Fri, 05 Dec 2025 04:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1764938863; x=1765543663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSPDA9RfToTwpDJtTTqEm8mN/hzTcDd0rmzkcW39oJg=;
        b=CK913crW5T3JSHv5sby7JPXIxKoFTqBPYTex1vG9oj+rz3VR0/sbsRhQ/R5CIc5uVF
         9Ixop1dEXyRmnVuficw7vQl79L6lAORupFJL3KjCMdNjCwcP4LMqMMgNGdAiCixakOF6
         hagco9Y7/X7veDfcn6E6s34i9L0y41qnNpZt9Hkl6KjQSoSQj/IWQc3NpgjSw9RN3EWh
         lCdOE3nuuHO2q7ltxaAiHtsxO2yNozFMHyCCmVt5FogMLGi5z9UieMR4ZIK5gpvhq0dW
         d2dJDKp6TdDjZ0QxdmlnENbDsioao6lc6WRIsBcalbRrt+uCRdrJs5TypdKHv+6h/S3X
         4jqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938863; x=1765543663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DSPDA9RfToTwpDJtTTqEm8mN/hzTcDd0rmzkcW39oJg=;
        b=KSZA0DX5m1CAVVc/UiLnRzn8KI/UKhcnbWCIo8vaBXNkwPeYlmzNA975wtGclWPpkw
         TMGv91o5P5xTSaWICUlb0uK70/SEMD/HFj8DPXFlMrTdXBpb36xInyHr01UCKbfBu9oc
         05tNRn0MRfI2EyY5VpeM8iM7fDO48cOZzbBCEqRkc5kOCzl5xUwkaauNOQ3bmNQ7cRbU
         +gugbqAF3O0/RACTXgWHM1hsLxm7inevUu7Sroye/IVKQaXcwoJWEVd40eKYjPmA7afC
         HZt3sc5OV40TjZNBWH+T4rww1gmsE/hNRxLsBqd0VINxXvuwUjmKJDssw0yhNYVhsdxR
         tUQQ==
X-Gm-Message-State: AOJu0Yy4Bkn0I0mwGgVmlxTRDdRuGVEIapkdPluv0nIWKlz3gAfH4Bhi
	sJWw9P7Roy3dC/JLZvysBM9NCOQswzjlrptups7RErVzCa1ipp6dUMmJjexjpVYTKGM12uiZoP2
	j94gD
X-Gm-Gg: ASbGncsbX3d0FadaYUj18a1XRYlAslAzyNeENrpMmb1Flvms7tlYSSVlA/4Gla6zhjm
	eUzGg/EFx/CtUi5DMn6mcE8zqFEUWyfzL4ngjAReZ2WP5AV0H32NmAYQCYnPuWu+tqVs6QgAVBI
	ganrhzMe4xr4SxGcPXdPQMgvv61r9a0wPWUOkic0iMwYR5uEhQUIUxuzkDJeT9ja8pGBRkiRzaP
	fOlPBTd+q4pF+C/SbYDpfag7CJb+/3vg+mqh4MUrBrBf3B9pkfEUWUY9PE1EPX4Vwj6qAmJguZm
	98AlbpYaxp29JlhR28elmcd/RxZCDdeuckSQctBtpdyAdu39brUdEBmmoM3XRJLuueae7bumJSH
	zLqjyeulJ+RJQs0DstcEc2idp6DSGbgo3JSwFddIrmC+zEGkft53FlmaK9dCLUGWAiX1qA5A2IN
	NIrJI8xk58gXQSq7YeAwCsqNd2h4UIIQOIfah8EDK+AStN30a8adfYte5XW+tuVDiXhjUGAhVqu
	zLMX71kFLRciw==
X-Google-Smtp-Source: AGHT+IFY2A3AhXioLuY6njlhwY/5w0L+ldtyUXu8FgGcbDRNmTBoMpKASr10FCTd98ANe37G0S7w6A==
X-Received: by 2002:a05:6000:1886:b0:429:b751:7916 with SMTP id ffacd0b85a97d-42f7985f26amr6798490f8f.45.1764938863067;
        Fri, 05 Dec 2025 04:47:43 -0800 (PST)
Received: from lb03189.speedport.ip (p200300f00f28af70a31ee45bb042915f.dip0.t-ipconnect.de. [2003:f0:f28:af70:a31e:e45b:b042:915f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm8540037f8f.11.2025.12.05.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:47:42 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH 6/6] rnbd-srv: Zero the rsp buffer before using it
Date: Fri,  5 Dec 2025 13:47:33 +0100
Message-ID: <20251205124733.26358-7-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205124733.26358-1-haris.iqbal@ionos.com>
References: <20251205124733.26358-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before using the data buffer to send back the response message, zero it
completely. This prevents any stray bytes to be picked up by the client
side when there the message is exchanged between different protocol
versions.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 9b3fdc202e15..7eeb321d6140 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -551,6 +551,8 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 {
 	struct block_device *bdev = file_bdev(sess_dev->bdev_file);
 
+	memset(rsp, 0, sizeof(*rsp));
+
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_OPEN_RSP);
 	rsp->device_id = cpu_to_le32(sess_dev->device_id);
 	rsp->nsectors = cpu_to_le64(bdev_nr_sectors(bdev));
@@ -657,6 +659,7 @@ static void process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 
 	trace_process_msg_sess_info(srv_sess, sess_info_msg);
 
+	memset(rsp, 0, sizeof(*rsp));
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_SESS_INFO_RSP);
 	rsp->ver = srv_sess->ver;
 }
-- 
2.43.0

