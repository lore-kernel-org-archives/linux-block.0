Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7497C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 04:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8348064E3F
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 04:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhBDEP5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 23:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhBDEP4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 23:15:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB51C061573;
        Wed,  3 Feb 2021 20:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JWNpbnyZqzRYkEJKXFPpQ+gv+9VW0iywE8N5U6sRF7c=; b=B8ZWvHmU8IR1lHV82/Zk+3KMk/
        KQRGMXzimBvhlMSaxNKiR4+KVFTYZCaX4NWfL9xKZj4XxCDH0pN2esF6XZyJSkOdwAfcRxX4C4TTq
        eHatHIFz90VrKwJTWk2EQ2QiuKABvrVkXXufUoNZdwTqOh7nSILewW41G0JXcaRLF3raoh+HKujHl
        ZzVcx69Wxr0lvrxG/aW9XYIyKxDzTBfUA/qmiQAqqziD4HN08hpOK8erMj1MhkwXxo+ysb86bKB+b
        hOZLx0O5jf9dHpNvG5wWdP8d4eh8tzG5DbSMGs3XcHveHrJHWZH0hipL/EHBjy87c4bgOWJEfzwLm
        EuVD+ezg==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7W2w-0002Ru-Mv; Thu, 04 Feb 2021 04:15:11 +0000
Subject: Re: [PATCH v4 1/6] docs: device-mapper: add remap_and_filter
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, Damien.LeMoal@wdc.com,
        snitzer@redhat.com, hare@suse.de, ming.lei@redhat.com,
        agk@redhat.com, corbet@lwn.net, axboe@kernel.dk, jack@suse.cz,
        johannes.thumshirn@wdc.com, gregkh@linuxfoundation.org,
        koct9i@gmail.com, steve@sk2.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pavgel.tide@veeam.com
References: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
 <1612367638-3794-2-git-send-email-sergei.shtepa@veeam.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef604ad7-1348-1ffa-e3c4-67d153620e08@infradead.org>
Date:   Wed, 3 Feb 2021 20:15:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1612367638-3794-2-git-send-email-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/3/21 7:53 AM, Sergei Shtepa wrote:
> remap_and_filter - describes the new features that
> blk_interposer provides for device mapper.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>

Hi--
Please see comments below.


> ---
>  .../admin-guide/device-mapper/index.rst       |   1 +
>  .../device-mapper/remap_and_filter.rst        | 132 ++++++++++++++++++
>  2 files changed, 133 insertions(+)
>  create mode 100644 Documentation/admin-guide/device-mapper/remap_and_filter.rst

> diff --git a/Documentation/admin-guide/device-mapper/remap_and_filter.rst b/Documentation/admin-guide/device-mapper/remap_and_filter.rst
> new file mode 100644
> index 000000000000..616b67998305
> --- /dev/null
> +++ b/Documentation/admin-guide/device-mapper/remap_and_filter.rst
> @@ -0,0 +1,132 @@
> +=================
> +DM remap & filter
> +=================
> +
> +Introduction
> +============
> +
> +Usually LVM should be used for new devices.
> +The administrator have to create logical volumes for the system partition

                     has

> +when installing the operating system. For a running system with
> +partitioned disk space and mounted file systems, it is quite difficult to
> +reconfigure to logical volumes. As a result, all the features that Device
> +Mapper provides are not available for non-LVM systems.
> +This problem is partially solved by the dm remap functionality, which
> +uses the kernel's blk_interposer.
> +
> +blk_interposer
> +==============
> +
> +Blk_interposer extends the capabilities of the DM, as it allows to
> +intercept and redirect bio requests for block devices that are not
> +dm device. At the same time, blk_interposer allows to attach and detach

      devices.

> +from devices "on the fly", without stopping the execution of user
> +programs.
> +
> +Blk_interposer allows to do two tasks: remap and filter.
> +Remap allows to redirect all requests from one block device to another.
> +Filter allows to do additional processing of the request, but without
> +redirection. An intercepted request can get to the block device to which
> +it was addressed, without changes.
> +
> +Remap
> +=====
> +
> +Consider the functionality of the remap. This will allow to connect
> +any block device with a dm device "on the fly".
> +Suppose we have a file system mounted on the block device /dev/sda1::
> +
> +  +-------------+
> +  | file system |
> +  +-------------+
> +        ||
> +        \/
> +  +-------------+
> +  | /dev/sda1   |
> +  +-------------+
> +
> +Creating a new DM device that will be mapped on the same /dev/sda1::

Sometimes it's "DM", other times it's "dm" device. Please be consistent.

> +
> +  +-------------+  +-----------+
> +  | file system |  | dm-linear |
> +  +-------------+  +-----------+
> +           ||         ||
> +           \/         \/
> +         +---------------+
> +         |   /dev/sda1   |
> +         +---------------+
> +
> +Redirecting all bio requests for the /dev/sda1 device to the new dm
> +device::
> +
> +  +-------------+
> +  | file system |
> +  +-------------+
> +        ||
> +        \/
> +   +----------+    +-----------+
> +   |  remap   | => | dm-linear |
> +   +----------+    +-----------+
> +                         ||
> +                         \/
> +                   +-----------+
> +                   | /dev/sda1 |
> +                   +-----------+
> +
> +To achieve this, you need to:
> +
> +Create new dm device with option 'noexcl'. It's allow to open

                                                   allowed to open the

> +underlying block-device without the FMODE_EXCL flag::
> +
> +  echo "0 `blockdev --getsz $1` linear $DEV 0 noexcl" | dmsetup create dm-noexcl
> +
> +Call remap command::
> +
> +  dmsetup remap start dm-noexcl $1
> +
> +Remap can be used to extend the functionality of dm-snap. This will allow
> +to take snapshots from any block devices, not just logical volumes.
> +
> +Filter
> +======
> +
> +Filter does not redirect the bio to another device. It does not create
> +a clone of the bio request. After receiving the request, the filter can
> +only add some processing, complete the bio request, or return the bio
> +for further processing.
> +
> +Suppose we have a file system mounted on the block device /dev/sda1::
> +
> +  +-------------+
> +  | file system |
> +  +-------------+
> +        ||
> +        \/
> +  +-------------+
> +  | /dev/sda1   |
> +  +-------------+
> +
> +Creating a new dm device that will implement filter::
> +
> +  +-------------+
> +  | file system |
> +  +-------------+
> +        ||
> +        \/
> +    +--------+    +----------+
> +    | filter | => | dm-delay |
> +    +--------+    +----------+
> +        ||
> +        \/
> +  +-------------+
> +  | /dev/sda1   |
> +  +-------------+
> +
> +Using filter we can change the behavior of debugging tools:
> + * dm-dust,
> + * dm-delay,
> + * dm-flakey,
> + * dm-verity.
> +
> +In the new version, they are will be able to change the behavior of any

          Either       they are able to change the behavior of any
            or         they will be able to change the behavior of any

I prefer the first choice.

> +existing block device, without creating a new one.


According to Documentation/doc-guide/sphinx.rst, here is how
chapters, sections, etc., should be indicated:


* Please stick to this order of heading adornments:

  1. ``=`` with overline for document title::

       ==============
       Document title
       ==============

  2. ``=`` for chapters::

       Chapters
       ========

  3. ``-`` for sections::

       Section
       -------

  4. ``~`` for subsections::

       Subsection
       ~~~~~~~~~~

  Although RST doesn't mandate a specific order ("Rather than imposing a fixed
  number and order of section title adornment styles, the order enforced will be
  the order as encountered."), having the higher levels the same overall makes
  it easier to follow the documents.



thanks.
-- 
~Randy

