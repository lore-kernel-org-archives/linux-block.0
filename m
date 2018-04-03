Return-Path: <sitsofe@gmail.com>
MIME-Version: 1.0
From: Sitsofe Wheeler <sitsofe@gmail.com>
Date: Tue, 3 Apr 2018 13:08:00 +0100
Message-ID: <CALjAwxgAijfiqHpiQQGY9MmqzFyU+pP2Q2UwwbsPg5u4N0Uzjw@mail.gmail.com>
Subject: BFQ/Kyber as default I/O scheduler?
To: linux-block@vger.kernel.org
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi,

Is there any particular reason the new(ish) BFQ and Kyber I/O
schedulers have not been added to the "Default I/O scheduler" choices
in block/Kconfig.iosched ? Is it because they are multiqueue only?

-- 
Sitsofe | http://sucs.org/~sits/
