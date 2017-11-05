Return-Path: <axboe@kernel.dk>
Received: from x1.router (mobile-166-176-57-8.mycingular.net. [166.176.57.8])
        by smtp.gmail.com with ESMTPSA id i187sm18420894pfc.96.2017.11.05.08.21.52
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 08:21:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCH v2] blktrace: cleanup/fix registration locking
Date: Sun,  5 Nov 2017 09:21:46 -0700
Message-Id: <1509898908-7175-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

One patch that fixes up a discrepancy in how we lock the queue for
blktrace registration, and one that fixes up how we globally
serialize registering the tracepoints.
