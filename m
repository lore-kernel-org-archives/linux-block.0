Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4C530DF8
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904116; cv=none; b=q1jq6JtT3dAQ8xXIeBCQkbCTaIzP5J0OoSUoe5P3AmaTlkF6eRmZiLLjN1By7CWfv4dhWbnjgSvSRtaw1yw7qLi12P5GlWfX+4qa+YqO+jnrn0bqiZQ7Lp29F0/BMD4Y0DnxvXitrRSJsbfjexVENDBEw+AB9FwXkqrzQ3h+wc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904116; c=relaxed/simple;
	bh=5a19gwXGLq3bKTmO2jtTD4Y3115TpWAXSYr3d9HM2EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Px4d/d1aXMZeRNHpRiMPiNOdOXhPXG0cfxunlaI+p7h9FmvqovOiCQYx2ywPCdhJMF7GO/NacCKWI9z3nrHwOZ9Pp0bcDDhj+u2dcPH8SGQKpHVdo4GsUpSER+0C/Ktm/n2f1qswEBTkMmoVz3St08VOnxG9agfd3Nur1jDtaww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C63W1STx; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C63W1STx"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1c9879395so3415885a12.1
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2026 14:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788904114; x=1789508914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UbmhUz6Xfzx8deQJdCI1gpOtevRs6BcM/dkqX1C9r8Y=;
        b=C63W1STxDAZddcxlcCLxs6Reua6Wc1LytdyW6iWaZNCWh4V9Ex1rdyYd4rEqGG2zVE
         ttJbK944NHQADmXOfYaoY/2k/k4G5qYQf/Kl3hXqzoaWlCIroRJD9BVPpeyNg4rS3625
         B0ZELsA63zqm5qPWvqszvGKBRHkykTbT0adzwRKKLN0kAr/GcLlnHurma48kmNJ32MBf
         jLOXUH3n1cbL5wGr5cn6eN9AWYa1Cfo1Ukb3oK7bKZKEE1rw+oxAw7e59+7za1BFz9fg
         TrA+QLOFS/k9Ylaw1LaUNgIC1cB39vY3yvQ719GXOJoz1NNIVLxpjIa+b5Cih3qRRro8
         Dtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788904114; x=1789508914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UbmhUz6Xfzx8deQJdCI1gpOtevRs6BcM/dkqX1C9r8Y=;
        b=ELMqWB66CCYkf+SYyCM4PU92I5xn3DeSpyskPtbER5ArG7iw5Fzh11p0NlR/AFohEP
         4DBx3xtn1rEPFJgBRKK1QiLg5Nbu9jEf1a9okH2SurbquAGpzP/SMYgrPcZCEdruV9Js
         Y1ZURGbm3fVu6qZa9rx7/jSWXKeVia73SJYIsooEWGe8/WD2QrT9NHk0SCIQkwXTas0b
         hc9Gk9faSuOHr1xYtUThXe9XzdiDaRl9JoZYQI82D9XRztQQmfRNopUDtqZYldbsv7iD
         hg0CbK7ufh3LEZLSpLP5sIXkGJ4mytPLtO2aCnDE6fzUsLNdRHquu69WizpRg3+4Mwm6
         GEUw==
X-Gm-Message-State: AFuF++lWSxdTEpLUvYu8E7/t7F7Shyshxz9MTjUmT3YTIlwpC8aensKu
	gjB07nGVO9K+Z6IzLR/htStB6NRUztmQYFcps1VXv9EiaUWCQjaaJED4xYCYcd0KD7YvfPjJ/PB
	CScs0p7T0oQAUCfu8MG1ZazdadewkSafcdq68HVjSrs+KcFetCQx1EzG6Y368oey+7Cc0tqWCRU
	1BgKkCWQFHNnUaZ9ZpYY8ToA8YwT1wzIEF+k2lNiYbzBRD70U2RteHSa657Q==
X-Gm-Gg: AYBFou3h3lDIi3pzI0CgZnqN+XLShZ7QFCciAtMtjq73MmXjmVee8OhF4NgYeT8VHSX
	ZqHUbnlXQXePNUV/L4lyP8UR6tpfUnyK+tyHe33AYSeH7xdgeyXJkI7ydBdxsG4QAHLpFAIXd+n
	5f0R0RsIyvI972ucBv+PYK+IQXhaSYUEXKXQbfmx7Pag6AKaqji/aj85EYODM56X0MzJLs2DNrz
	WqFPb77RAJxOv3HLhwsKgwoCVYPOs63wzxFq7uT9F6ExH/rH4Mq5oPCstIPbQ4CpUOJv35VXoqR
	uHvUWq90fYD5WUNy2KFpWLvMFz22DLRoSZ2kkIgCUYK1ZP/BM/rWl7CQwlWFvniiCJUEofjtvZB
	ggr/6sVfW7HBYvEzhHvLzga2FJpjWNLlqkIY0qNbVvDTcMcLt7j4iXFKM50CYoA3uZ/Nd1JYd0m
	v+0K0vz/JmciRbDIhwtyVPJzRRILHBLSC8xfRJR7SkP53zX7pD8bB8Lpx8RpMW7LUtMemsCN5SF
	P1zIlp3AP5t
X-Received: by 2002:a05:6a20:7284:b0:3cc:f280:ebc6 with SMTP id adf61e73a8af0-3da39eacf9amr44790839637.5.1788904113410;
        Tue, 08 Sep 2026 14:48:33 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm39976824eec.27.2026.09.08.14.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:48:32 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH blktests] src/Makefile: fix HAVE_C_DEF probe under a non-bash /bin/sh
Date: Tue,  8 Sep 2026 14:48:23 -0700
Message-ID: <20260908214823.2366812-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HAVE_C_DEF feeds its test program to the compiler with "echo -e". The
$(shell ...) function runs under /bin/sh, which is dash on Debian and
Ubuntu, and dash's echo has no -e option. It prints the flag literally,
so the first line of the probe becomes

    -e #include <linux/ublk_cmd.h>

which is no longer a preprocessor directive. The header is never
included, the tested macro is never defined, and the probe reports 0
regardless of what the installed headers contain.

The only user is HAVE_NEW_UBLK_INTF, so miniublk is skipped with

    Skip miniublk build due to missing new ublk interface(v6.4+)

Use printf instead, which expands \n in any POSIX shell, and pass the
substituted names as arguments so they are not reinterpreted.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 src/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index ef9c887..dd64694 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -8,8 +8,9 @@ HAVE_C_MACRO = $(shell if echo "$(H)include <$(1)>" |	\
 		$(CC) $(CFLAGS) -E - 2>&1 /dev/null | grep $(2) > /dev/null 2>&1; \
 		then echo 1;else echo 0; fi)
 
-HAVE_C_DEF = $(shell if echo -e "$(H)include <$(1)>\n$(H)ifdef $(2)\nHAVE_$(2)\n$(H)endif" | \
-		$(CC) $(CFLAGS) -E - 2>&1 /dev/null | grep HAVE_$(2) > /dev/null 2>&1; \
+HAVE_C_DEF = $(shell if printf '$(H)include <%s>\n$(H)ifdef %s\nHAVE_%s\n$(H)endif\n' \
+		"$(1)" "$(2)" "$(2)" | \
+		$(CC) $(CFLAGS) -E - 2>/dev/null | grep HAVE_$(2) > /dev/null 2>&1; \
 		then echo 1;else echo 0; fi)
 
 C_TARGETS := \
-- 
2.55.0

