Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932283AbcK1NxK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 08:53:10 -0500
From: Jes Sorensen <Jes.Sorensen@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, hare@suse.de
Subject: Re: [mdadm PATCH] Add failfast support.
References: <147944614789.3302.1959091446949640579.stgit@noble>
        <20161122020238.qtuxwo5etcwmts4r@kernel.org>
        <87polka0vu.fsf@notabene.neil.brown.name>
Date: Mon, 28 Nov 2016 08:53:08 -0500
In-Reply-To: <87polka0vu.fsf@notabene.neil.brown.name> (NeilBrown's message of
        "Fri, 25 Nov 2016 10:55:49 +1100")
Message-ID: <wrfjfumbpv7f.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

NeilBrown <neilb@suse.com> writes:
> Allow per-device "failfast" flag to be set when creating an
> array or adding devices to an array.
>
> When re-adding a device which had the failfast flag, it can be removed
> using --nofailfast.
>
> failfast status is printed in --detail and --examine output.
>
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>
> Hi Jes,
>  this patch adds mdadm support for the failfast functionality that
> Shaohua recently included in his for-next.
> Hopefully the man-page additions provide all necessary context.
> If there is anything that seems to be missing, I'll be very happy to
> add it.

Hi Neil,

It looks reasonable. The only minor concern I have is over the use of
hardcoded magic numbers like 'dv->failfast = 2' rather than using an
enum or defines with descriptive names. Something that can be addressed
later, so patch applied.

Cheers,
Jes
