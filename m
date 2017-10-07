Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:56071 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbdJGVmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Oct 2017 17:42:06 -0400
Received: by mail-qk0-f176.google.com with SMTP id x82so10888059qkb.12
        for <linux-block@vger.kernel.org>; Sat, 07 Oct 2017 14:42:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170909184147.10458-1-colyli@suse.de>
References: <20170909184147.10458-1-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Date: Sat, 7 Oct 2017 14:42:05 -0700
Message-ID: <CAJ+L6qc6xReHHwHnZx6oRL_H3u2JCEY+zaBhJ88-tzUrHhZUMg@mail.gmail.com>
Subject: Re: [PATCH] bcache: rewrite multiple partitions support
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Indeed fixes a bug where minors and indices are interchanged on
cleanup-- good catch.  Factoring out the index conversion is nice.

Hopefully no one is adversely affected by the stride change (16->128)
and different naming, but they should be using udev + labels/uuids
anyways.

Reviewed-by: Michael Lyle <mlyle@lyle.org>
