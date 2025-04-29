Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E55276026
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966472; cv=none; b=FharLZO6AMYgByEEEDKAgvAcIpCqyblHsj52f/u3en17KScGfu1vghD7Bo1Ap5thgFCd1Q07zfTtAWaNTLVGiYlJuabA7MqUCxCQEvcP+pl+6ow32bmXRqJp6NcLSb4yq7KrTyPjgB/IqsUat9K85E8CEmHgrl9AxkiaT577Erw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966472; c=relaxed/simple;
	bh=yLjCvoCe6VXMT5MsUjHgKpFFAFBbBtQRcr91r8jHk+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vy0+hDTBKAa3BnoLKlk5wogPzAwd+m3AXOf6dZuuyhJ0KaUQJX0Ab/4o12jqOYDEZ5CRjRtcpVNJ9PQBm4gIx86G5fRJkOWmVW/b3jk0wOOysHQZ1C33Mw5kndMW/yuYNcCRPVzo7jjDEIcasXzl7mp/tCgRXRoSA71+5fwi3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LwqKwcsW; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LwqKwcsW"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2240b4de12bso96229775ad.2
        for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745966470; x=1746571270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFNtS618ufyKJDtfH/r/PyGi4nE5aM2nCuyHf6tRb3Y=;
        b=LwqKwcsWiHCt0Ma4fVElW3asrerOszOKpN0s0hzAvtiMJPqCAoFGGvNNRgXDX9Cf7S
         ZYYWkvnueOR5YH6AXoBwp0ywutmIfIL3iSN8+Teu8N6RDD3EWiY3Ct8gx7dVdnZEMVZp
         Wf6c1/JNeztMCGffl7q1cMvUUBiLKdMGDg2aJdDNpqlYr/67Xsi0VqjgqIHeWotNTtgp
         dj5oVroce5AkxbB4/g0K13X/nGEXXOANwqaGmtE2vylF3hHmcWvBK0NlKV+kX61Nq66m
         b5dMFMF8yeUIP5we4+t9qiZA/D1ApZ/o/DQD564ytiq/CECJq+z9Nx4m7LeFo5bVfUZI
         EjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966470; x=1746571270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFNtS618ufyKJDtfH/r/PyGi4nE5aM2nCuyHf6tRb3Y=;
        b=IO5L9U1x7PWFnAg9B3q4f29Ki7ZfN0Y/u76T2yo4GO0MHfitNDPNBXCyH535gkiJmq
         u+ReN2fdukd7k3Yubt6Yj3+bh3yZatZZu3Y6MdOuFE0S4CgGoV0QtHT1ZXwM3Im//0lC
         xVJj2iWQbcSq7Zvt/Ipw6D7WlFFUV9PXhzvokwq5LMkEkrPDi0z0mT0vw9wRolbvLJ+E
         0z9gs96ydNLCWJ/MhuwikF+H/zOpci3dDe5YOCXVHPd32MLWVpz1C2sWJrATpNb3NJUW
         F6r7F8GYzUhaGcIOzg5flbCkUWxvsN+ssmXYD9cUf1cc5xf7s3lDDggCm/tzk6fUybT3
         yj+w==
X-Gm-Message-State: AOJu0YwRQkkcmQoSxpJjk/a7kGyClDL8vqsciy7u7R+aaXMWsPkfR1W5
	UL81He9qCcyBDQvQSjW/E9nU7crOK4oIXb41x/+f2RgKxlBbb1d1Nulx4dbs0v2D/CFr6atS7K1
	7KfB5hdc3lTJYzQFcG4YFL8FcTD70jr2eEJUWINLxX6OuDG7p
X-Gm-Gg: ASbGncsRaETdnbbLKurVJnq5TFPCLLkH+kj2Po7Qt07JPakti5p0X0/QJZDMLagga2n
	UfkwuBrSjTmyn4miqcS7tnJGXsFPElKnHoIuoQpvlnEYqSxNDR4sQ34FAVPTONxVVcmOMq4th6h
	iUvSoTcpZ12QmrS7D4PTPGm4rLUElehtX+AW1NIvz+3uykUM3j+VaMJkZ0Mx+NqFN9ZJ4CXS9ne
	ITbFd4n5hcF0Zdrb1XTm7/tCKxUC/jgbWA0EGXMMikDDTrqiL8XMenwFy2LS7h6ZfkgTBXqEI7i
	+yco9Hn889NEaekQ69l1sIQT1j1CB00=
X-Google-Smtp-Source: AGHT+IGBZ7D6TEnAUN4d7huIcnUzTzs2CYiqo4tm38ieihvVaysSOYFpmF+9wSpzUkmmpxVwAfixH06NtvV6
X-Received: by 2002:a17:903:3c66:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-22df57638e7mr2895685ad.8.1745966469787;
        Tue, 29 Apr 2025 15:41:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b15f7ec226dsm809653a12.1.2025.04.29.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:41:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0055634034F;
	Tue, 29 Apr 2025 16:41:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E501DE40EC9; Tue, 29 Apr 2025 16:41:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 29 Apr 2025 16:41:04 -0600
Subject: [PATCH v2 2/3] selftests: ublk: make test_generic_06 silent on
 success
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-ublk_selftests-v2-2-e970b6d9e4f4@purestorage.com>
References: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
In-Reply-To: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Convention dictates that tests should not log anything on success. Make
test_generic_06 follow this convention.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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

