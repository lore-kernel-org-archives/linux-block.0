Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33915 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753477AbdDEMBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 08:01:48 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so2059501wrb.1
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2017 05:01:48 -0700 (PDT)
Subject: Re: [PATCH v3] blk-mq: remap queues when adding/removing hardware
 queues
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <20170331204603.GB11462@vader>
 <9753ebd0c51a9d49f110a6d0d00888170905d97a.1490993257.git.osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a48ef9a3-4935-e990-db68-75d1b157ccff@grimberg.me>
Date: Wed, 5 Apr 2017 15:01:42 +0300
MIME-Version: 1.0
In-Reply-To: <9753ebd0c51a9d49f110a6d0d00888170905d97a.1490993257.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
