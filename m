Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36779 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754969AbcJEVoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2016 17:44:12 -0400
Subject: Re: [PATCH v2 5/8] blk-mq: Cleanup blk_mq_hw_ctx::cpumask
 (de-)allocation
To: Alexander Gordeev <agordeev@redhat.com>,
        linux-kernel@vger.kernel.org
References: <cover.1475241231.git.agordeev@redhat.com>
 <49a669af2c7e281527b31727392e4ad781831c80.1475241231.git.agordeev@redhat.com>
Cc: linux-block@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <94a8e0fa-d33d-c514-a703-0cc04e357380@grimberg.me>
Date: Thu, 6 Oct 2016 00:43:55 +0300
MIME-Version: 1.0
In-Reply-To: <49a669af2c7e281527b31727392e4ad781831c80.1475241231.git.agordeev@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
