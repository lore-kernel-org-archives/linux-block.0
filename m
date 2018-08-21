Return-Path: <axboe@kernel.dk>
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2956501ioj.59.2018.08.21.08.05.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 08:05:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET 0/3] blk-wbt fixes
Date: Tue, 21 Aug 2018 09:05:14 -0600
Message-Id: <20180821150517.19744-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

One cleanup, and two fixes:

Patch 2 - Ensure that the wait queue active check includes the necessary
memory barrier.

Patch 3 - Ensure that new tasks don't supersede already waiting tasks.

-- 
Jens Axboe
