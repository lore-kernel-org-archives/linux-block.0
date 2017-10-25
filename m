Return-Path: <axboe@kernel.dk>
Received: from x1.vtm-guests.local (50-76-103-53-static.hfc.comcastbusiness.net. [50.76.103.53])
        by smtp.gmail.com with ESMTPSA id 62sm6386083pfw.129.2017.10.25.11.04.50
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 11:04:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCH 0/3] mq vs non-mq scheduler tweaks
Date: Wed, 25 Oct 2017 12:04:44 -0600
Message-Id: <1508954687-3204-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Small series that streamlines this a little bit, and also introduces
name aliases since that's now easy to do with the mq vs non-mq
explicit scheduler lookups.
