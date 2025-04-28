Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DEC213255
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881845; cv=none; b=TURJZ9tPLweHPy+3IJQo6GqXUOGjMCbyjbFQa3Xm4zvFDi3jIpruz+uO7K8m/PkueOOXRrY6KKTceZi4A/cZF5ZBRsW4H5OXBs8OQ6V+8wrFp8f+6iyl9pEpHchgRgSGIKJXfDV7386eOrueoVm3L6xnbVQsKHVUtv1zeX8cAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881845; c=relaxed/simple;
	bh=7qGhW0lObjamK2vkejF8Y9mV1B303QKOHDtBCxKSc/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzEqQZwLlZpfr9iQeBtQaGDBLWCwjrecY3ITK0K+9wP78rLi+0kuDpSxcSPR/akF6MkVy1oERosYrfJz5hCZp+mtZWDRj6nvCJ3ij+Ihb0a3hUAZkYLCTyPBpRjiZSyL+jBW2aizl9XaYAs7cVjCzIsllBIEL5DoZTX3SvZbcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Qwg3d+sz; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Qwg3d+sz"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-527b70bd90dso2255747e0c.3
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745881842; x=1746486642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bmz20arlb8RcX2p20KSIo8CkAzDOxhHq99zIjNZrVW8=;
        b=Qwg3d+szDdvNKGHasY0mJtoELugv8k19HwrB4bG+7fHmF6w/ZdO3bEr2mePCzJtFld
         1ZmMqiHlU4FgFJXt0j438mbMt/ujwSl6zN5Barz8N2dCmbe6lCAQjo7JCF0CU5AuNrFg
         qsyJJdjUCc6JW+5529Q3piA1teaADBVRoIsMe45tCPzTzpW6pmeaMAHlv4b1sLBSWxh9
         8Ivybg2vQw6TXY4HifMoefoZrVcf1/nMwjuYjO6i3HyVPow4WW5OBYDhlt5VM2r7ybOn
         keEZYpueQUFdr4VfY8GB4btyHA9VCwFUZgD10GHBTXWVf6fOsj8mCIdTmZIwk9ziLhIs
         p1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881842; x=1746486642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bmz20arlb8RcX2p20KSIo8CkAzDOxhHq99zIjNZrVW8=;
        b=G7qdRramVHroFM+AXDF98VVqlwecfnp/jMaa8LkV/ECFp65Fc8TW1e7CWv8t0PcpvQ
         T4tTmZrEsqj97m7AFOGoAvsH9/CKDq7R+NOH1p+ZJijLumElPzIHtfBk+yk3wu1v/mu4
         LgfQit/iQAubedgwRVqfb/bAP5LF/qVkpZ5jN1Y7XOuI9xleGirIj/N0W4AdR3WxwI8u
         w0ts8DPjcsLrS2syqH/RW5UD4x+cSMEt6YHRU3SkVEjiZyqQwrI26ngHgpBhQrUq780B
         7eHvY32K3GUF2V0MlDjHBLl22wjs+iIac7V3CmKEmbGf1bX+KSPTqUAWIFWo3j389Kpr
         kdng==
X-Gm-Message-State: AOJu0YyPhvBTgq1305vtyvbH5OozPApjaLUWIsdf2oltJhmt9JbsneA7
	/JIVq4MBazMUvKXn3p8+RJ0XKu+7DyLf8HAektN65AXTMHqU4LNfg+rf5t5OMOu81gTJ9QhzF1G
	sX1wNBeAR97AOYw8CSSzltXq/g0Y6Luxm
X-Gm-Gg: ASbGncuM2ZotL6bIoVBt3BcSEDXH6Sgv4h674/hz2H3Z4r/Q+NvU03+cqv7DsdDExtB
	pz0xMLP97UOJBwhyIlhe1eoyaGr4+YEndVkr51Qd4sVeoHiaySROZyBOXhvJGrrquyLaNkMY+i2
	unWaMRa6a0NvC4RwofImkuw1y8RNXhHmOP5QbpxyJrTAG26p47zkCnu18IHqBWMQStqvpjqvoJQ
	w/fe7BRwYeekd2aU9Mh04z/hoOtYbZhgnn84Fwwja8hts0dSG/h4k4sWvq3tMBcIlDSGFEJ3RGq
	AfYU1WqN0XesjCvj+WH9iSX6HUHUT+2XkEVHodAt+7j3BA==
X-Google-Smtp-Source: AGHT+IGM4smmOhtgP/4+Uo/a8IWC8EW5NjjaSX4wyDUOukBYYBtb2f/7+HWxfvUz6i44U/GswKTrYMpTZVq1
X-Received: by 2002:a05:6122:d04:b0:529:b2:ea5e with SMTP id 71dfb90a1353d-52abf0421e8mr1039622e0c.2.1745881842049;
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-52a993a2955sm790539e0c.10.2025.04.28.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 49A673418B8;
	Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3B199E4191F; Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Mon, 28 Apr 2025 17:10:21 -0600
Subject: [PATCH 2/3] selftests: ublk: make test_generic_06 silent on
 success
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-ublk_selftests-v1-2-5795f7b00cda@purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
In-Reply-To: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Convention dictates that tests should not log anything on success. Make
test_generic_06 follow this convention.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/test_generic_06.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_generic_06.sh b/tools/testing/selftests/ublk/test_generic_06.sh
index b67230c42c847c71b0bbe82ad9de1a737ea3cb75..fd42062b7b76b0b3dfae95a39aba6ae28facc185 100755
--- a/tools/testing/selftests/ublk/test_generic_06.sh
+++ b/tools/testing/selftests/ublk/test_generic_06.sh
@@ -17,7 +17,7 @@ STARTTIME=${SECONDS}
 dd if=/dev/urandom of=/dev/ublkb${dev_id} oflag=direct bs=4k count=1 status=none > /dev/null 2>&1 &
 dd_pid=$!
 
-__ublk_kill_daemon ${dev_id} "DEAD"
+__ublk_kill_daemon ${dev_id} "DEAD" >/dev/null
 
 wait $dd_pid
 dd_exitcode=$?

-- 
2.34.1

