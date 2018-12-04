Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD8C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141EF2146D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141EF2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbeLDBIs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:08:48 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:37404 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLDBIs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:08:48 -0500
Received: by mail-ot1-f53.google.com with SMTP id 40so13591210oth.4
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZTkHp2a/CqnDWsjR4O4XvZkH8t+XMvF15FIYduNlo0s=;
        b=Y4nyZbtfIx2KBOXYqe1TQem/56AEyRzpACSNVHVGQlJDRUsvyDtre/6sDiWnRJ27rS
         kwLd2ANd4oBGVmBTk0rvWvJHMAZtbqQpVl4d7ZacLw50+gsk/UX9NIZavl3wv0XYvUai
         TFZxbbHkbLh68jq3Y1qxS+Jr5Z/zpfJn5GWQvXcC7dWrN8j1UG18JfRgM3fVyOvcPXIX
         8Cr0Zv+8HYZbrVyO2J4tFT8pXaAfSNnafZgStKEHfqUir1VQIFYcimKym128O9U761Cu
         pWIFMB8f2jcd6WwwQEfBmVwFSW9/0nUsaJtBT89KUon65ze97gRC3WPNVqhIsF5WvHA9
         3grw==
X-Gm-Message-State: AA+aEWZgAM3SXVbMpdRzSm3gJk66zH3rpzDwj3X7EJQWBflNh0M8lq7G
        0GIu1dM0bFSuFPoeTBqMDwy60YuR
X-Google-Smtp-Source: AFSGD/VWtJn6tWKXvYx0NMX5vvBD6v6iyYIbotOjw09QdTW63gilCwVfRzFs4R3P/3GGFgArolvv7A==
X-Received: by 2002:a9d:19eb:: with SMTP id k98mr10966275otk.205.1543885726432;
        Mon, 03 Dec 2018 17:08:46 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id p203sm14800573oic.49.2018.12.03.17.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:08:45 -0800 (PST)
Subject: Re: [PATCH 08/13] nvme-pci: remove the CQ lock for interrupt driven
 queues
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-9-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9c0d0bdf-cf47-ae54-8277-73ac608d99cd@grimberg.me>
Date:   Mon, 3 Dec 2018 17:08:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Now that we can't poll regular, interrupt driven I/O queues there
> is almost nothing that can race with an interrupt.  The only
> possible other contexts polling a CQ are the error handler and
> queue shutdown, and both are so far off in the slow path that
> we can simply use the big hammer of disabling interrupts.
> 
> With that we can stop taking the cq_lock for normal queues.

Nice,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
