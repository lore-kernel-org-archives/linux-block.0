Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D812283FF1
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430197; cv=none; b=dGHvKJBuxMiKX9haGo+8OWZpCjKW3XMtBXFWuXQ6KiFUrivhnUoSmTyPwDOVBtPW6HZvGSP8vdMrt2PwwA4O6a+kIsUtRlxYaEZn1PyWvlm/Uq0qZMmlL0X8spoRX0TKa+0fE1OnkgPHJSEEJAxXrJrVI4tWwjZI0NXtYO3pDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430197; c=relaxed/simple;
	bh=ugv+L91iD/mMt+noj9DgZ/5IYV37F5CcVIOzFhnzFT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj56wLU7kE5FoZRYxDnT8zn9HDqKHqvy7qDuMfftm/RB9nJfW9fZ0I5fjeQyJ/DKh3pByQyoCgR4r9r60KDZRgyiN9tshWbNemtgM7sCEWsbSukVJMocbuj7vP5hRvhP/r0XNBIgL12w2Gkek3elh47L4Ss388V6UDiG6RhnAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Nj/B95mi; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Nj/B95mi"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8b530003d70so13757185a.2
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 21:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430193; x=1766034993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTqVrM+5dB/aV7gHI1xfO04fFWnueqKpNcCVf0mzNKQ=;
        b=Nj/B95miIPSr2sIWs0H87r+i3K+uNy8PV6XxYLe2ANopteY7u0954rSK6jP6s+9qfJ
         CF/9aeNyoXDuEw+iDsQ9Bru6wRccI5jK1+gEK6y91Jm1B/WQeT20++28aObd+SaY3j/2
         aMUjHkPI7CMuYtms1fvliBjA8LYCYfJ++bCOuOsWOQDU5khx9azO8S1K4mAyqCtiyNcu
         6rYCQ124u6Jw2xcuwtBtJd9oTWtW67F8huw4KD3cz9E+Lmdqq4amyal0H0rvjtfHIVzF
         fXIT42+mmVnFCszrqgzh6ejGESx20ojMPmEXojMrMt8ZbLflr94/Nx3Sn7zVHnMxslgE
         7u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430193; x=1766034993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTqVrM+5dB/aV7gHI1xfO04fFWnueqKpNcCVf0mzNKQ=;
        b=nn+8z05n0QtQ+mH8lyX9lY0PLbAet5LIlUjPb9x+lkL5bDMQaWlAEzZcWZryD5vh9u
         KTw8uv/+kPHOMWmWyPk7HJLV8erqXQ1KAKvgd6LJ9DhuDHoodUcOjS2hGGxPGKwhv1GT
         QNmnXUZnBvzS1TXj+oEaB8a0bbccdYHSRfe2WTa9/NyWOGYMVEf+bZpfHMgkSmOXYVCm
         Q87wDyU8szCjE/S6ci3M9BBtKCL0mkassOkR67fUCNrSMxlezpxt8xvAyJeza4s61+zO
         C5FE/0/hbMImDRmHaLgmVNAhh0YKuaVXWe2etLjj1cX+axME9i0TQoByWz6TgLgkGM8o
         YrwA==
X-Gm-Message-State: AOJu0Yz1abYnmb37gXRu1BK9R2bTarFtPMLr7uSrAArknF0+/pwqQbxh
	J0o36IJuPFZzLq4iXYdwD5uzOPu8FPIKI6GPgE4U8P14EFXa9kh1jt5X48cUv9jr0wQX8wPbL1c
	DRU5HkBghb95uib68lN5ZEK2UgFJcNbsph0Py
X-Gm-Gg: AY/fxX4uIRUnSB7fPGt9KlAgMrr+Y6CkqTgOmk3zATGAKzSPyzlD5ivsrPUANQXVEV6
	YX9Wgi/WftzqezmI585W+RcHkf46mUjbu4RVk19VXh9DCAACA/Yuz2nadQKrKlICjey1H6astDN
	fFn9THKqhRCh5SuJEulH2fCvTJ6lNdoD2ZWqeApxFRrqAAKKxNP1mO9D7cdfa3K85k1Qb1r+nj8
	cQoItNfI7nTLC3W93shCKn7W52l3q4dkgYo2DIKzEdofmPHEg4D2KDTCwi4ettZi72iIzXQApqY
	jHkzHbm5w06+Or+Uof1M6N6ozgdpvBVQ7bPqvP8hsTt0Z8RODunx4xFpdsOCLrl2bpNnJkmDrNE
	5MFJoEdF5mFKuwsp1Bg29UodlBSFoLQAVJXFQY9C6Vw==
X-Google-Smtp-Source: AGHT+IEVMLDi+M2lvlTlTsrMZUIr2MTV2dKnDHRpqfJSsfAFAo3GmlWwvbybr1q1ad2xu+lmxYt/buCaOMKm
X-Received: by 2002:ad4:5de1:0:b0:880:55fc:c984 with SMTP id 6a1803df08f44-88863ae917amr55498616d6.5.1765430193191;
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8886eedef55sm2845916d6.18.2025.12.10.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CD284340B96;
	Wed, 10 Dec 2025 22:16:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C9DE5E400B8; Wed, 10 Dec 2025 22:16:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/8] selftests: ublk: remove unused ios map in seq_io.bt
Date: Wed, 10 Dec 2025 22:15:57 -0700
Message-ID: <20251211051603.1154841-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251211051603.1154841-1-csander@purestorage.com>
References: <20251211051603.1154841-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ios map populated by seq_io.bt is never read, so remove it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/trace/seq_io.bt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index 507a3ca05abf..b2f60a92b118 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -15,11 +15,10 @@ tracepoint:block:block_rq_complete
 			printf("io_out_of_order: exp %llu actual %llu\n",
 				args.sector, $last);
 		}
 		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
 	}
-	@ios = count();
 }
 
 END {
 	clear(@last_rw);
 }
-- 
2.45.2

