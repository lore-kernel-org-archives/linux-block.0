Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:45492 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeANJfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jan 2018 04:35:04 -0500
Received: by mail-wm0-f45.google.com with SMTP id i186so19510767wmi.4
        for <linux-block@vger.kernel.org>; Sun, 14 Jan 2018 01:35:04 -0800 (PST)
Subject: Re: [PATCH v3 1/2] block: fail op_is_write() requests to read-only
 partitions
To: Ilya Dryomov <idryomov@gmail.com>, linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Tejun Heo <tj@kernel.org>, David Disseldorp <ddiss@suse.de>
References: <1515676152-18476-1-git-send-email-idryomov@gmail.com>
 <1515676152-18476-2-git-send-email-idryomov@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <faa8f6ee-2bf3-0863-e9fd-5b1e782c5106@grimberg.me>
Date: Sun, 14 Jan 2018 11:35:01 +0200
MIME-Version: 1.0
In-Reply-To: <1515676152-18476-2-git-send-email-idryomov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
