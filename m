Return-Path: <shhuiw@foxmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
From: Wang Sheng-Hui <shhuiw@foxmail.com>
Subject: Why the field 'depth use different data types in sbitmap and
 sbitmap_word
Message-ID: <dbca3ab6-c4e3-4415-7def-a056e415e036@foxmail.com>
Date: Sat, 7 Jan 2017 21:21:10 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi,

Sorry to trouble you.

I have one question about the define of struct sbitmap & sbitmap_word:
      In sbitmap_word, the field depth is 'unsigned long', but in sbitmap, the field depth is 'unsigned int'.
      Why they use different data types?

Regards,
shenghui
