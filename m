Return-Path: <axboe@kernel.dk>
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z128-v6sm8366088itc.21.2018.10.11.09.59.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 09:59:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET 0/17] Convert drivers to blk-mq
Date: Thu, 11 Oct 2018 10:58:52 -0600
Message-Id: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

The long term plan has always been to deprecate and remove the
legacy request_fn based IO path. This also means killing all that
code, and going back to maintaining a single IO stack again. To
accomplish this, we need to convert the remaining drivers to blk-mq.

This converts everything but the floppy drivers, which should be
coming shortly as well.

-- 
Jens Axboe
