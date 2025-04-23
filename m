Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6624466A
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443747; cv=none; b=DWXIrhXus5Fd3DGHdPXyrKMqjl3qf1Lcjzv+jbxdCrV70/uvM0IFcqcL5W8JfSRUe6dZooXdP2jsWiHupd/oHi7PfLDBP4F95+mU5Q+4DPle4vIjTfjWUTKdkFdDLEzyYFrBnOB1L/VD5P/MR7vc+fmt/2SD32XdUEYlEzzfc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443747; c=relaxed/simple;
	bh=D9ftuTBIipMMMb+INoV/N9oBXuVjGGG57prHPs3PuGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IlQtpkP+PUdQaSa8ufPWw9xAtE1561xzRW1bQPnrW0/S9iJimto0Cji/rsrNGc7DXoVw+n3NhSDd2CKPJWDF+UKTvYaLXrLJQMtlrd2U6uXbnoglgrcVuKw8sNUe1T2nefV86zWhN8Jvh/v/2ak9FnyzOHot/B9WqQCcEiNO+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fR++VZPQ; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fR++VZPQ"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2295d78b45cso4835685ad.0
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745443745; x=1746048545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FfkdId7QoskoICSJ3Xv6KLiuYz8Ht/aFE5W2Si3esE=;
        b=fR++VZPQK2WtODPxiZttcKwzUqpd92FEr/+qEtOTiKZkS6E37yiQMW0q7glp+0nHAF
         NcwA8GlP9r6Zr9YY2yDqRLGHV2TownrkvlRVn1+vGqeteT73s+V0jWZPCz0/tSz9O4wv
         myMYUSkMuE0jnH66Fzn/KVYEa6u5+e0a44rOAiB1P+0ZF02al48O6fv9+FDTHV9qaEMe
         Gi5rQars3hPUd54q/massO9V78dN+26ZRYcwb49p3scAacK8FFcAhHHahhdbi3MrRcZM
         J8ldIFvyxvR9K8G0bd80SqXzXdf6udzKgMUcdtjvxLsjxSpLC916njdiEdS5BX8MIsdW
         JDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443745; x=1746048545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FfkdId7QoskoICSJ3Xv6KLiuYz8Ht/aFE5W2Si3esE=;
        b=Wr7vY3q7CqNFB2UkfDxxPn5LVYRrcYZqcFSu9mTy3Oz+dKZakgs6hPqVndHbu38VFs
         yVR42ep73255+F41tQ1uDUWR/ImdVTF4aQKCWs0E4K5ffH+N651vIpKFsyD6PUDIpkqM
         ScdFCU8nYDMLVm7+GbOPI7OJcCzkDmbLqcU1IHmzbh2fty40PGjF5vLtjfc+vUEabprI
         D5r2arrOyeI45PgzVvwQU2fDBggwx5qP+HDJVK6Djq3WXKjBfJ0+PN7CG34UfsLWM507
         tu+niUmlU9dDIzRZpbvU9SB70v8qwIPszBEJX3MmkDdPhQbVa5uHU7ZAoEjHkNUwSZ2v
         /Oyg==
X-Gm-Message-State: AOJu0YwxDt7sEHo2l09u3z39fQjvCWGSpS5B6TvddrUUQiDrkK7Uo1hh
	wCvSv+7CrobCSVz4pzomVGzi5VnUKQqcv5wiqse0+3gnMUA9PyaHiY2StwNt4roXL6cX/NKPnBZ
	GIxWMHVsSFtOy8bwH+hRtHiVfFg7jayrqQS0C5+mZFziV7h36
X-Gm-Gg: ASbGnct7XEp3tQOwzIFmhXXmV13wTDbM8AzRWo2SQ2qeenctTsPRUYN2pA68OPULytL
	oZWtxz04pwcig1tLysHtFgz5Ui1Mfo5YRpzOFg9P7rqqPrN0fbvVb8+NoIhckX8q9UacAvGwBiE
	BhC1QfZMBnCY5b9AooetLJT7AufLr6OG4EBSRg5z0wHVTecXOPlKZV9fkgw9vMK51clsxjzdTeR
	LI/JVGgQyzgNLP0p9de2nlgluhVGCf9Lo0N2GYca3M/AwAC2APd58ZaGZ1DKR2/GfDkQmMiLbKK
	yhdFBejvN2B3y6z53l5zz0aI2eSLCGY=
X-Google-Smtp-Source: AGHT+IGAMoZZFngPD9ZZ3v3uIDuQwCl93Fgjflm9tE0fW/Q3qQPIK/rfA5ej5yiEulIgWPS4pv9hVx43DNB+
X-Received: by 2002:a17:902:da8a:b0:224:191d:8a79 with SMTP id d9443c01a7336-22db3c0bf2amr834295ad.27.1745443744799;
        Wed, 23 Apr 2025 14:29:04 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22c50d88a78sm6232705ad.100.2025.04.23.14.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 14:29:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F22C134058D;
	Wed, 23 Apr 2025 15:29:03 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E5B66E4031E; Wed, 23 Apr 2025 15:29:03 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 23 Apr 2025 15:29:02 -0600
Subject: [PATCH 1/2] selftests: ublk: kublk: build with -Werror
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-ublk_selftests-v1-1-7d060e260e76@purestorage.com>
References: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
In-Reply-To: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Heeding compiler warnings is generally a good idea, and is easy to do
for kublk since there is not much source code. Turn warnings into errors
so that anyone making changes is forced to heed them.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index ec4624a283bce2ebeed80509be6573c1b7a3623d..57e580253a68bc497b4292d07ab94d21f4feafdd 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -Werror -I $(top_srcdir)
 LDLIBS += -lpthread -lm -luring
 
 TEST_PROGS := test_generic_01.sh

-- 
2.34.1

