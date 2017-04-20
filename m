Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:22884 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764977AbdDTCjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 22:39:03 -0400
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 4/9] bio-integrity: fix interface for bio_integrity_trim v2
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
        <1491332201-26926-5-git-send-email-dmonakhov@openvz.org>
Date: Wed, 19 Apr 2017 22:38:52 -0400
In-Reply-To: <1491332201-26926-5-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Tue, 4 Apr 2017 22:56:36 +0400")
Message-ID: <yq1d1c7pzur.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Dmitry Monakhov <dmonakhov@openvz.org> writes:

> bio_integrity_trim inherent it's interface from bio_trim and accept
> offset and size, but this API is error prone because data offset must
> always be insync with bio's data offset. That is why we have integrity
> update hook in bio_advance()
>
> So only meaningful values are: offset == 0, sectors ==
> bio_sectors(bio) Let's just remove them completely.

This interface predates the iter/immutable stuff. It should be fine to
remove the call arguments now.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
