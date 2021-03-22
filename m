Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F544C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 07:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE75F6196F
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 07:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCVHuN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 03:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCVHt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 03:49:58 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539BCC061574
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 00:49:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q3so9632623qkq.12
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 00:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdYbX1lteOBwhkyNfi6D2Jmq8cQAJlo4XY28RQPU2sA=;
        b=bkRa+rshm6YMoxJcQkZ0KfWG9jCNHIr/UQhklJG9Rgnhsf64hZdwjSWA4hX8FNbEgN
         IgyvjybD2/S5rpU/X6oaTEnPbFObO+zaCGjvACUk29p9WU6KKvv/E/RQESKyQsuXpggs
         nvTDRT9v6C4KQ6gQ8lMI4ixexwGUNOy0RUGTyBm35gWQejkc0m87KfkU0C9iEeucL9df
         yGK6If9Q6zJN9JwrTV0FPLxVLu15Q/wMhfCxiKDGN0AYjb09b6byfWCYWHvKjmoLnCVR
         awvQ+pW2o5PZD7PG1Zx4tEPtLm1aVk2lT+wORkvAB5Uoi3KjosTiBjKdRzSfBkq9S9C3
         sV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdYbX1lteOBwhkyNfi6D2Jmq8cQAJlo4XY28RQPU2sA=;
        b=iuvTJVNrYWF/aA1axByNzh9vU5hMPZgAps6twyvmc/Bt05kgmVphnkRRodzn0PXy4r
         LYS00JQeYpsVAUHro6R+u4Yi8AFIcW2jqWS62ZJ2lM4UTXBZOF+imdsnX0op7cfSoZXg
         L/cLeFQEwaJlOIBkQFFbhvHiyIDbADiKV2eVzW//aNrGmdEMMRy3yZQ9t1q5vNTIIy+s
         8klBa1cOgVwWj7MnCcgDHnQUoaCIHUS2TTy2P/XbJUKH64zxPslVRQS3Wot8mE2yPcVI
         ah+A7Q0Fl3c57LmNl9I4tTPLAL44fyqkQl5UOcrGXAAslnBeMncH5coNJEqZ5V4U+cqg
         eSgw==
X-Gm-Message-State: AOAM533/54h+V5yIvryHlOhHA95USEbz09JaKVAOmOtb5O+q/eknRJ3v
        vNnHteZlvIJKWrsGkCPnh/Dnzswnqy+2M/6RyvKKMQ==
X-Google-Smtp-Source: ABdhPJxAIoJKu7FdQTOldr6rYJb4dltQXuYIwByoH4qJ9DpEFzerNaXUNS5rnknv4fAhRcGJjuUsgmvJra2W9u12NdU=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr9877450qko.424.1616399397132;
 Mon, 22 Mar 2021 00:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000053da9405bd7d2644@google.com> <000000000000a17fb305be0b3f38@google.com>
 <20210322071801.GE3440@lst.de>
In-Reply-To: <20210322071801.GE3440@lst.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 22 Mar 2021 08:49:45 +0100
Message-ID: <CACT4Y+bDdmUH4eJV0P7OwT_z1pSi3CWs9fFrtiO89obtK6mpcw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
To:     Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e24a1905be1b4ff7"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000e24a1905be1b4ff7
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 22, 2021 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I've been running the reproducer on a KASAN enable VM for about
> 15 minutes now, but haven't been able to reproduce it.
>
> Is there a way to inject this proposed fix into the syzbot queue?

Hi Christoph,

Yes, since this bug has a reproducer, syzbot can test patches. See:

http://bit.do/syzbot#testing-patches

It would be, for example:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master


> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 1a7558917c47d6..f5d5872b89d57e 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -288,15 +288,12 @@ struct device_type part_type = {
>  void delete_partition(struct block_device *part)
>  {
>         xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
> -       kobject_put(part->bd_holder_dir);
> -       device_del(&part->bd_device);
> -
> -       /*
> -        * Remove the block device from the inode hash, so that it cannot be
> -        * looked up any more even when openers still hold references.
> -        */
>         remove_inode_hash(part->bd_inode);
>
> +       synchronize_rcu();
> +
> +       kobject_put(part->bd_holder_dir);
> +       device_del(&part->bd_device);
>         put_device(&part->bd_device);
>  }

--000000000000e24a1905be1b4ff7
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kmkaeeyy0>
X-Attachment-Id: f_kmkaeeyy0

ZGlmZiAtLWdpdCBhL2Jsb2NrL3BhcnRpdGlvbnMvY29yZS5jIGIvYmxvY2svcGFydGl0aW9ucy9j
b3JlLmMKaW5kZXggMWE3NTU4OTE3YzQ3ZDYuLmY1ZDU4NzJiODlkNTdlIDEwMDY0NAotLS0gYS9i
bG9jay9wYXJ0aXRpb25zL2NvcmUuYworKysgYi9ibG9jay9wYXJ0aXRpb25zL2NvcmUuYwpAQCAt
Mjg4LDE1ICsyODgsMTIgQEAgc3RydWN0IGRldmljZV90eXBlIHBhcnRfdHlwZSA9IHsKIHZvaWQg
ZGVsZXRlX3BhcnRpdGlvbihzdHJ1Y3QgYmxvY2tfZGV2aWNlICpwYXJ0KQogewogCXhhX2VyYXNl
KCZwYXJ0LT5iZF9kaXNrLT5wYXJ0X3RibCwgcGFydC0+YmRfcGFydG5vKTsKLQlrb2JqZWN0X3B1
dChwYXJ0LT5iZF9ob2xkZXJfZGlyKTsKLQlkZXZpY2VfZGVsKCZwYXJ0LT5iZF9kZXZpY2UpOwot
Ci0JLyoKLQkgKiBSZW1vdmUgdGhlIGJsb2NrIGRldmljZSBmcm9tIHRoZSBpbm9kZSBoYXNoLCBz
byB0aGF0IGl0IGNhbm5vdCBiZQotCSAqIGxvb2tlZCB1cCBhbnkgbW9yZSBldmVuIHdoZW4gb3Bl
bmVycyBzdGlsbCBob2xkIHJlZmVyZW5jZXMuCi0JICovCiAJcmVtb3ZlX2lub2RlX2hhc2gocGFy
dC0+YmRfaW5vZGUpOwogCisJc3luY2hyb25pemVfcmN1KCk7CisKKwlrb2JqZWN0X3B1dChwYXJ0
LT5iZF9ob2xkZXJfZGlyKTsKKwlkZXZpY2VfZGVsKCZwYXJ0LT5iZF9kZXZpY2UpOwogCXB1dF9k
ZXZpY2UoJnBhcnQtPmJkX2RldmljZSk7CiB9Cg==
--000000000000e24a1905be1b4ff7--
