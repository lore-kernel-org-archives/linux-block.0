Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B323EA93
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516627; cv=none; b=izRDTT7yOnEBGCv5vK8ryw6NJAKiyG+08lX0lUURmvLNp1pA4GoJ1oD1MdfhSx8BL32LJx600WC6tiUe65xo2eBAXRQN/+7N7BUbMvoVRsT2TNJ4LdMNUDntnS2/SYh0lb4Vi8zvXIk5XJBS2CqI2xA+3ZXg81cJRfKcBgzzs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516627; c=relaxed/simple;
	bh=Nv/iP0PPlu7PYFQwI+jBPI8ffRylYj1zxIf1qEKb0tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U16vTc6npp2Gk1/Cwu3OAmEjoltrhpxxzsMeAddjQRhQyoBkEIYHgxlYZqgdEUpIGDhS+WBA29ekUnhJaXj9Bmm3b4PZtLtkhCzczOZhy9Ea1yUzSii14mZgS8GnxMy/3Cqd5NWaLepM7fAIQLEVJv1AVJx3jTUbVHNro7Zl+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MWCugvxG; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MWCugvxG"
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-b7639da2362so14371966b.1
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 21:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516624; x=1766121424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro8OsZF3uJAug4OtKve3tUbRbgxB29DrKAw1agkxt6A=;
        b=MWCugvxGJ5bcaQvBBCe1EmAUmVNkByLHzjxtweQxeEFnrCecaqahJ9CiRCBIIkuydN
         MxQHmXwdCOjCuq+uJxdAAtmiPpFWVKJoVYfz3vNCopWvy/E1rEn3UI2F44zdkRQUey3J
         nZ9YcqhYf5OGls7PC0umB4f9+5BpUb2+HYSUdUdLoZZvMmM47qkm5bq+1Z+uprJKrJfi
         1WQHbrNS0cEqie8Sr7+T4xAPt/Roa6MpZdMDM5NlvpNO7fJkMR5LhUmeGkkAHeuTqJ0X
         jJkAtUum3tKjyG0jD6S8rcBAWZtMMLUjtopMRrYF89udxUR1cHf1bNxNLwvOGy0bFBRm
         3t8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516624; x=1766121424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ro8OsZF3uJAug4OtKve3tUbRbgxB29DrKAw1agkxt6A=;
        b=EPeBIe2HQ2YOgSDCidBmpp6VO8t6XM7OL5Reor4RVw185XKCx9+rHwVb3AZbEqlXjT
         eax1fU4hJZ0NYGNs3Ovuoe4DRcnHataaUXJ26d44d/GYH6dWT0+6MH5TtOMXLZ52QX7f
         BWABUwBKACUWwUKSZOnbVqnvL/j5hmJ2uW+oO/V5xBP65yc3OE7jSnx4G2Akc+6yC38N
         nyVxfPLnNO7pcVRrrtb7KBzzhf7sTkJ4IWpEeerICAG5PKMjaSKqJpNbEuZ+Ds6U3/48
         VxjmAHwJOGF0r478nAC/0y2CqHQIQvoW7k5LUxlPRT7jtge/i/34ACS6QSwsvoGzXbbe
         Qohw==
X-Gm-Message-State: AOJu0YxWrEVmSAeOlDVqOMlMQI0gBTpjPYeyond/qwHtGvG/oTzGfHQf
	9FP+KOzPVgK5EQf9AXgHQn/NQFKX0muRWOeWobP5xp9G/QPWLXbCrFiy2QWs5eYJbnBPDitCRVc
	ILD/KmP+nSA4mS2/B8sOEp+9E22IaUopsLk6G
X-Gm-Gg: AY/fxX5Ei8Cn823ut1aOi22lVhMEu3v7UCfgc0ftIU7E3S2Oo+6H2DIoUj57sbxQHrW
	MAobiWE3rqWhU/E3ILTG2jJvjN/HkfyXQM3hmdxyYWi6Vq067HooiXQJ4GmAkmuzH4SiwTjQB5L
	CgmjZ6MVnC1hHASouwn/0j7/siUsu9Co7rZXkPp73S32e7oSfVocFj3dGD1WK183raVEyTl8ZA9
	JI+iGIxIMsZyp9mtm1TSan7H3ayaVFnofgKwlX1KfHf5y2cz1Irg5sUdzxIKQ40voVNM6oO33Ny
	1EcCJOmGhyA7KjoSgdIKmh7s8m3Lah0YE1HN45aThVVsHDp52tdNjkPu0m5zkO6gPF4JyV0tj+B
	7MOWlCDr4bHRlqkJMTOWG2HGjci4OeSOEIQxZ6y5cGA==
X-Google-Smtp-Source: AGHT+IEawf1to/V+/+Qx4OvUJswtkr88PbpqURl0CG0xqAJjTju6BHqC8DK8KJbweq/Q9sRitTwQT4JGUkml
X-Received: by 2002:a17:907:60d0:b0:b76:c498:d410 with SMTP id a640c23a62f3a-b7d23aa5780mr34437166b.8.1765516623927;
        Thu, 11 Dec 2025 21:17:03 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b7cfa609a26sm86779066b.86.2025.12.11.21.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:03 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9E989340B96;
	Thu, 11 Dec 2025 22:17:02 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9B464E41A2E; Thu, 11 Dec 2025 22:17:02 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/8] selftests: ublk: correct last_rw map type in seq_io.bt
Date: Thu, 11 Dec 2025 22:16:51 -0700
Message-ID: <20251212051658.1618543-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212051658.1618543-1-csander@purestorage.com>
References: <20251212051658.1618543-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last_rw map is initialized with a value of 0 but later assigned the
value args.sector + args.nr_sector, which has type sector_t = u64.
bpftrace complains about the type mismatch between int64 and uint64:
trace/seq_io.bt:18:3-59: ERROR: Type mismatch for @last_rw: trying to assign value of type 'uint64' when map already contains a value of type 'int64'
        @last_rw[$dev, str($2)] = (args.sector + args.nr_sector);

Cast the initial value to uint64 so bpftrace will load the program.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/trace/seq_io.bt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index 272ac54c9d5f..507a3ca05abf 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -2,11 +2,11 @@
 	$1: 	dev_t
 	$2: 	RWBS
 	$3:     strlen($2)
 */
 BEGIN {
-	@last_rw[$1, str($2)] = 0;
+	@last_rw[$1, str($2)] = (uint64)0;
 }
 tracepoint:block:block_rq_complete
 {
 	$dev = $1;
 	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
-- 
2.45.2

