Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:7267 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933110AbdEYNTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 09:19:18 -0400
To: Paolo Valente <paolo.valente@linaro.org>
CC: <linux-block@vger.kernel.org>
From: Hou Tao <houtao1@huawei.com>
Subject: BFQ: the purpose of idle rb-tree in bfq_service_tree
Message-ID: <ac72a25b-c96d-6c3a-8108-9cd546a882c3@huawei.com>
Date: Thu, 25 May 2017 21:18:43 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Paolo,

I am reading the code of BFQ scheduler and having a question about the purpose
of idle rb-tree in bfq_service_tree.

>From the comment in code, the idle rb-tree is used to keep the bfq_queue which
doesn't have any request and has a finish time greater than the vtime of the
service tree.

The only function that I can find and reveals the purpose of the idle rb-tree is
__bfq_activate_entity(). In this function, when the activated queue had been on
the idle tree, the start time of the queue will be reset to the greater value
between min_vstart and finish time. It seems to me that the idle rb-tree is used
to delay the schedule of the queue which issues requests periodically, but I don't
known why the delay is needed. Could you please explain the purpose of the idle
rb-tree in bf_service_tree and its main scenario ?

Thanks,
Tao
