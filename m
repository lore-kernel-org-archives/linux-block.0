Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34809 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeCPSpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Mar 2018 14:45:49 -0400
Received: by mail-qt0-f196.google.com with SMTP id l25so11936071qtj.1
        for <linux-block@vger.kernel.org>; Fri, 16 Mar 2018 11:45:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-2-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com> <20180315150814.9412-2-bart.vanassche@wdc.com>
From: Michael Lyle <mlyle@lyle.org>
Date: Fri, 16 Mar 2018 11:45:48 -0700
Message-ID: <CAJ+L6qfz-3_69UvAtdM3mqmZHKjODjt877m6ZSFv581q=_qjWA@mail.gmail.com>
Subject: Re: [PATCH 01/16] bcache: Fix indentation
To: Bart Van Assche <bart.vanassche@wdc.com>,
        linux-bcache <linux-bcache@vger.kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 15, 2018 at 8:07 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> This patch avoids that smatch complains about inconsistent indentation.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
LGTM, applying
