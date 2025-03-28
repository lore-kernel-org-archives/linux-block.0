Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1E1E32D5
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190993; cv=none; b=GgaI3wreqFNQlvdhUyHoFjXC6uJ1Wb0M1t/5J1jeuQ4wxI2vqfEiI/XCs3FKBt6XBRec2W5kQQwwBeBdjCFFh1RkBlBRU/rjxO9W2RAxyV0pyXze3F/RGS8GkD3gRWDutQ2UspkQ+7GyvGkmPJlWrVwnpMNYnUB4SrT8UDZPD5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190993; c=relaxed/simple;
	bh=OLxAmO7yW2b8KKMedc+3ZdU1b31cGrrllojaBB9EdZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmZzZTJYLZsOwsTyABbSwAFlyX//oaqZc5lpNIUhPuC53SNEBspVxlbSIl32W95MNWXtcfvfHVGnZyQzhqfk6E2kn4hA0m/3KJOeoG1QwLdOczbFoEy+nKTs47CxvQR9AL1ITWcwvTd/SYzik40BKBbrmuCjhtv8SUS044GdKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CjUcN1RR; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CjUcN1RR"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6e8fa1f99a6so3028386d6.3
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743190990; x=1743795790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODvPSfxlecP14OuA5OKuO2EdeJD2/HHQgbxBXvFdj/Q=;
        b=CjUcN1RRgmd+h+DNqzoT+AT4x2H0VyxybgSxUTZmtuIJt/T5OKfyfLb+EeTJEuL6ER
         K3UFIT5X582QF19jXN2+I5Eh7Jazrzpn6+Um0BCy+NEyQtvApDXsZ+Odawppg0Ds+tHe
         9rFDJvFsdp0hAoM8JQMkFIXopy54/05JIP1eSNh2vxZq0EsHo/wvVLWiyeVF5yRKL/ng
         SRIqaR9cFLQuV1MZKf77XrfO7gGEG6BZmJR1VWuvIBjce3E5OtW1zgdBVfEsdPDpnou5
         l0ngFK1b+2jrcJkKsIt/fMemEQccCIKGsMCQwraSEv5rRiv+OmqZ4ngcWhhC7eODDEtc
         8E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743190990; x=1743795790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODvPSfxlecP14OuA5OKuO2EdeJD2/HHQgbxBXvFdj/Q=;
        b=uEfPw/oz/gDaybHg+Qp8bM1gO2VCrqwII9e4pKaI9H58hbAWjQMf2VbT9VO6GZrPo8
         ngTg9YyCRR9jIsnL4TSiOnxwmzbhdPNK0Qkh6CVAmxY3vb2S0DciyEZvv3MRaP2kLGUr
         9jNkCMnXmWo6YjofIgMUZElNtsobs6gr0Sy0WirEN6hMWan6aS34tf8rSGNbuJKa1c9I
         fBL5TcHABfoAZJRgA7p8D114yL2PukPSeSLJRaHFiBnVks3HhgnQaqPm1yMsY4VIO1Ph
         lw3RKb2C3iaBad4vrh3N/XbAS7e1ZPCpsEbyIy83WEqk1GiQqImnVICGDvAtMa9JnRS/
         qtog==
X-Gm-Message-State: AOJu0YwezMfhAFPALozTWJjlL25fnqQXs+cUkLtJwO++QW0WOcObiR6j
	0S/8WXEzNmN39gpMavFVRZSRKqjG42UIpg/azln4osMrvQeTjps2LyGWEyvq9JvIhSNX0JVOkbY
	6dtXsaxAPZ2kGgWUYH7TmmmWAP3gssj2oYzSAT6ndACpvS7jn
X-Gm-Gg: ASbGnctUYvc92SJXsu7vt2NSFfAx0cRYIhjK4KG0OvpvjT+IYH3PWvvP2At/DNs4jGm
	KwjQiG/TCh+OGsN2395SBbARshq04ERpgMP2Y9NHRUwRF+RT7dEVheR1uXg2+xgnsWdmTt29uy/
	E8Y1DagOz4rz1nM5+CBs+Ci9YY5au7h526/bm6TPeibQPOFV35WAsNi58Bdsx0QBazr7A0zAtTY
	SozIVOXnZNd7uatZjCUQzOPNPCahnTGmklItuZ7MDQjF9cqo2eCT/zLAnym39pqUDj5AiPt4aOi
	2/ZvP64lTD5Kgn1GiJ0qbnaI1EGm3qF9pA==
X-Google-Smtp-Source: AGHT+IHE1BDqSoPFQBosK4FIZagJvkov+uoLlZNqBQtT2+qBsIa0Cb6b1jpVWKVmQ243c8hGamaf9x1PNGPX
X-Received: by 2002:ad4:5bae:0:b0:6e8:8f31:3120 with SMTP id 6a1803df08f44-6eed620e64dmr1735846d6.8.1743190990230;
        Fri, 28 Mar 2025 12:43:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6eec97b6bddsm2788096d6.70.2025.03.28.12.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 12:43:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2B899340325;
	Fri, 28 Mar 2025 13:43:09 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1D2D2E40AF7; Fri, 28 Mar 2025 13:42:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/2] ublk: specify io_cmd_buf pointer type
Date: Fri, 28 Mar 2025 13:42:28 -0600
Message-ID: <20250328194230.2726862-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
char *. Indexing the array requires an explicit multiplication and cast.
The compiler also can't check the pointer types.

Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
indexed directly and the compiler can type-check the code.

Make the same change to the ublk selftests.

Caleb Sander Mateos (2):
  ublk: specify io_cmd_buf pointer type
  selftests: ublk: specify io_cmd_buf pointer type

 drivers/block/ublk_drv.c             | 8 ++++----
 tools/testing/selftests/ublk/kublk.c | 2 +-
 tools/testing/selftests/ublk/kublk.h | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.45.2

