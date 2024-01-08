Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC1254F8B
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K5IiTam2"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-360576be804so1470225ab.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 11:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704740476; x=1705345276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHHwjg/OcXa0+bACAPF7Cl7jKM6kr7v5+HC7Mv5gEsM=;
        b=K5IiTam2Iy9Ehqgt+L1+d/yK54KFRrdBYsWujEDIjeRmVbs9nqODx6OwmjHBzGRA/X
         UipFa8Wx+Op9/OAv175NusD0+Afo4cdZIhR9ORwihFi0vZirhutdsCmpI+bO79luIBhp
         LonoX5hi9z/ehEM8a51etNHYkWwKWcDstKSDJSCnuIk64MP04Qxuj9NKBk6NipgdCcXd
         G+o154vfp+8McrBLRKgs2PYKLpFX6Q5ZoXw0BkewKHTPhgyYg5NW56xbnFZvy4tpxsuk
         uAr5j555koPwjz4Rnn5/CppiFm/lBj0ndrB3Pz/lfIu3pVXHYJi8CNHl6r0Ebikg1amn
         m/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704740476; x=1705345276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHHwjg/OcXa0+bACAPF7Cl7jKM6kr7v5+HC7Mv5gEsM=;
        b=YiV7PyVye5Q9QbqOoQB1skgNFAWhJrIREyVBHtPc0RIBGaHN5xSubjJLLkvABjl2G1
         sj0S9MtNVfoXibiJZxhYSFEzj9m86y5lHcegAQFhqDlCvOsHzAs2bPGrfA360Zd3rZe8
         Txj2a/vpDjzV46m36Ou8UwjpGRvI3Xtpg/dnxUo9ZCUrtvb4ENJE+cTXWOy1mM4Rra81
         cH5hOjDdLfAuxU1KT930bq7N5suyD/Btyj77y2IVSSmbtG7CVMY01Od2E7I/gmklGZc7
         zonbN8caju+XJJBi0BRqWVEG1ozct86fwQXIABkAEnNzi1z3XHNUXQWrYRo8cpQmlsTz
         3j8w==
X-Gm-Message-State: AOJu0Yz+F2RrP00X9RK2JNDXaSCIcYEjhLYMGbhZ7zaAgzSinmQ2ZzWd
	0hEWAGps5BzNLWV1Ff1AcPPCu/QThEWF474o8qiBPwoWJeUf3A==
X-Google-Smtp-Source: AGHT+IFYRC1xm/mrpA9JzAgyH7sDQYVTc8sPITlCGE7xRARqZ5ARC5dUGbTtM2AwdULHpVu57kOhUA==
X-Received: by 2002:a6b:d317:0:b0:7bc:2603:575f with SMTP id s23-20020a6bd317000000b007bc2603575fmr6943786iob.0.1704740476306;
        Mon, 08 Jan 2024 11:01:16 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z12-20020a029f0c000000b0046dcb39c1d3sm128206jal.28.2024.01.08.11.01.15
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:01:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET 0/2] Optimize get_current_ioprio() a bit
Date: Mon,  8 Jan 2024 11:59:54 -0700
Message-ID: <20240108190113.1264200-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Came across this one in some recent profiling, and it's actually
quite grim:

+    2.71%  io_uring  [kernel.vmlinux]  [k] __get_task_ioprio                       ▒

Just do the easy thing and move it into the header so we avoid
a function call per IO for this. Patch 2 is just a general cleanup.

-- 
Jens Axboe

