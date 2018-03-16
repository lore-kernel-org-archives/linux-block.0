Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44613 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeCPSsh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Mar 2018 14:48:37 -0400
Received: by mail-qt0-f195.google.com with SMTP id g60so11905639qtd.11
        for <linux-block@vger.kernel.org>; Fri, 16 Mar 2018 11:48:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-3-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com> <20180315150814.9412-3-bart.vanassche@wdc.com>
From: Michael Lyle <mlyle@lyle.org>
Date: Fri, 16 Mar 2018 11:48:36 -0700
Message-ID: <CAJ+L6qchvtEvVns1Ev0FF4y=9Sv1NHAqQ6fo1L2EzcoAYhNdSA@mail.gmail.com>
Subject: Re: [PATCH 02/16] bcache: Add __printf annotation to __bch_check_keys()
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 15, 2018 at 8:08 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> Make it possible for the compiler to verify the consistency of the
> format string passed to __bch_check_keys() and the arguments that
> should be formatted according to that format string.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

LGTM, applying.
