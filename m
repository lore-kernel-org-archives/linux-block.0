Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4FCC04E84
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53352087B
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw/dPt/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfEPOcP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 10:32:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39354 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfEPOcK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 10:32:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id y42so4125911qtk.6
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X8Zn0Ao5+NlF3rVXz5zRXX+lJ34YqVoy4hz0BMVmeC0=;
        b=kw/dPt/T0pFLManSsIA+MRgz7dLyswMCxpBoBK6RYP9TvbnG5+dEWXmlhahmnMy8pf
         oal8VfF2Cj877boI8J/Oz53sQ+abDDRqZT5AjZbdS9HwIox56NEeuv1PqGU/Q/nzyir9
         Lf/0HccQm8QbtwuvqF449FcOkCxlzy4bMfwaP3/q9D1pFARDKTFdhQoIcDih9Ke6OpmC
         km2WPwv2B3AqKW945SIS+TJkDnstb3cnixDMCRKsyQwvcMngSQTkmhmTmn7EBl/annym
         Ycoml7ZPSyl6pl1K3+uZs+mxroTzsxOL6MjPSpRPHjjcwM03pT8BAtivSAyXFt8oI5ns
         Fbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X8Zn0Ao5+NlF3rVXz5zRXX+lJ34YqVoy4hz0BMVmeC0=;
        b=fLxGp5wdAGI/mOEFxVFXtb1xbQ3FIQq7QTH7CNSki1ADWeqmkq8zae/WTmIdoWBWsb
         NWGhnxqg84yumxEvDlOnY10lT64xWUI9nuIOMmYU266gtfOXfNgKau8abW21biF1JPen
         yg0KNA9H7uX84lcCMGzhLh/WPFAusBFw/tzgf3IboZvLEn9WcCqreUiaF5JW3niLz1SA
         /b2BtJfBsl5vdkQJnS3xqSbapZbP024/22EgE6CxpZD80sYcE91b7Xqqpxg7h0zZuyNV
         GsgiLfbbEURXVI+gMOrIUzh1pzgawzcVooCwMuZlDHfw589hmt5bzrUXjPZbK1krdN5C
         9LQg==
X-Gm-Message-State: APjAAAUFtn/5pF8LS7jk7p180MU0TcmZXtsMPZUCZAcDwLRhstphyRlB
        7lGX9DxKty2WmqbrgSUWRaw=
X-Google-Smtp-Source: APXvYqwqbyY/Biluv92FiPwVOXOXCbK63r67F7rPvK2jDDYHhUK5972NbxA1J46u+agIWydR7P4rjQ==
X-Received: by 2002:a0c:b64c:: with SMTP id q12mr40943352qvf.50.1558017129220;
        Thu, 16 May 2019 07:32:09 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y13sm4119292qtc.21.2019.05.16.07.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:32:07 -0700 (PDT)
Date:   Thu, 16 May 2019 10:32:07 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Bryan Gurney <bgurney@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Colin Ian King <colin.king@canonical.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Helen Koike <helen.koike@collabora.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Martin Wilck <mwilck@suse.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Peng Wang <rocking@whu.edu.cn>,
        Sheetal Singala <2396sheetal@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, Yufen Yu <yuyufen@huawei.com>
Subject: [git pull v2] device mapper changes for 5.2
Message-ID: <20190516143206.GA16368@lobo>
References: <20190513185948.GA26710@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513185948.GA26710@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Seems you haven't pulled my 'for-5.2/dm-changes' tag from earlier this
week so I've added 4 additional simple commits to this v2 pull.

(Last commit being trivial janitor patch but I'm being hen-pecked about
it by the author on LKML so figured I'd include it while getting you the
3 additional substantive fixes).

The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.2/dm-changes-v2

for you to fetch changes up to 8454fca4f53bbe5e0a71613192674c8ce5c52318:

  dm: fix a couple brace coding style issues (2019-05-16 10:09:21 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Improve DM snapshot target's scalability by using finer grained
  locking.  Requires some list_bl interface improvements.

- Add ability for DM integrity to use a bitmap mode, that tracks regions
  where data and metadata are out of sync, instead of using a journal.

- Improve DM thin provisioning target to not write metadata changes to
  disk if the thin-pool and associated thin devices are merely
  activated but not used.  This avoids metadata corruption due to
  concurrent activation of thin devices across different OS instances
  (e.g. split brain scenarios, which ultimately would be avoided if
  proper device filters were used -- but not having proper filtering has
  proven a very common configuration mistake)

- Fix missing call to path selector type->end_io in DM multipath.  This
  fixes reported performance problems due to inaccurate path selector IO
  accounting causing an imbalance of IO (e.g. avoiding issuing IO to
  particular path due to it seemingly being heavily used).

- Fix bug in DM cache metadata's loading of its discard bitset that
  could lead to all cache blocks being discarded if the very first cache
  block was discarded (thankfully in practice the first cache block is
  generally in use; be it FS superblock, partition table, disk label,
  etc).

- Add testing-only DM dust target which simulates a device that has
  failing sectors and/or read failures.

- Fix a DM init error path reference count hang that caused boot hangs
  if user supplied malformed input on kernel commandline.

- Fix a couple issues with DM crypt target's logging being overly
  verbose or lacking context.

- Various other small fixes to DM init, DM multipath, DM zoned, and DM
  crypt.

----------------------------------------------------------------
Bryan Gurney (1):
      dm: add dust target

Christoph Hellwig (1):
      dm crypt: fix endianness annotations around org_sector_of_dmreq

Colin Ian King (1):
      dm dust: remove redundant unsigned comparison to less than zero

Damien Le Moal (1):
      dm zoned: Fix zone report handling

Dan Carpenter (1):
      dm zoned: Silence a static checker warning

Helen Koike (2):
      dm init: fix max devices/targets checks
      dm ioctl: fix hang in early create error condition

Huaisheng Ye (3):
      dm writecache: remove needless dereferences in __writecache_writeback_pmem()
      dm writecache: add unlikely for returned value of rb_next/prev
      dm writecache: remove unused member page_offset in writeback_struct

Martin Wilck (1):
      dm mpath: always free attached_handler_name in parse_path()

Mike Snitzer (5):
      dm space map common: zero entire ll_disk
      dm thin metadata: check __commit_transaction()'s return
      dm thin metadata: add wrappers for managing write locking of metadata
      dm thin metadata: do not write metadata if no changes occurred
      dm integrity: whitespace, coding style and dead code cleanup

Mikulas Patocka (13):
      dm delay: fix a crash when invalid device is specified
      dm writecache: avoid unnecessary lookups in writecache_find_entry()
      dm integrity: correctly calculate the size of metadata area
      dm integrity: don't check null pointer before kvfree and vfree
      dm integrity: don't report unused options
      dm integrity: update documentation
      dm integrity: introduce rw_journal_sectors()
      dm ingerity: pass size to dm_integrity_alloc_page_list()
      dm integrity: allow large ranges to be described
      dm integrity: introduce a function add_new_range_and_wait()
      dm integrity: add a bitmap mode
      dm integrity: handle machine reboot in bitmap mode
      dm integrity: implement synchronous mode for reboot handling

Milan Broz (2):
      dm crypt: move detailed message into debug level
      dm crypt: print device name in integrity error message

Nikos Tsironis (7):
      dm cache metadata: Fix loading discard bitset
      list: Don't use WRITE_ONCE() in hlist_add_behind()
      list_bl: Add hlist_bl_add_before/behind helpers
      dm snapshot: Don't sleep holding the snapshot lock
      dm snapshot: Replace mutex with rw semaphore
      dm snapshot: Make exception tables scalable
      dm snapshot: Use fine-grained locking scheme

Peng Wang (1):
      dm: only initialize md->dax_dev if CONFIG_DAX_DRIVER is enabled

Sheetal Singala (1):
      dm: fix a couple brace coding style issues

YueHaibing (1):
      dm dust: Make dm_dust_init and dm_dust_exit static

Yufen Yu (1):
      dm mpath: fix missing call of path selector type->end_io

 Documentation/device-mapper/dm-dust.txt          | 272 +++++++++
 Documentation/device-mapper/dm-integrity.txt     |  32 +-
 drivers/md/Kconfig                               |   9 +
 drivers/md/Makefile                              |   1 +
 drivers/md/dm-cache-metadata.c                   |   9 +-
 drivers/md/dm-crypt.c                            |  26 +-
 drivers/md/dm-delay.c                            |   3 +-
 drivers/md/dm-dust.c                             | 515 ++++++++++++++++
 drivers/md/dm-exception-store.h                  |   3 +-
 drivers/md/dm-init.c                             |   8 +-
 drivers/md/dm-integrity.c                        | 717 ++++++++++++++++++++---
 drivers/md/dm-ioctl.c                            |   6 +-
 drivers/md/dm-mpath.c                            |  19 +-
 drivers/md/dm-rq.c                               |   8 +-
 drivers/md/dm-snap.c                             | 359 ++++++++----
 drivers/md/dm-target.c                           |   3 +-
 drivers/md/dm-thin-metadata.c                    | 139 +++--
 drivers/md/dm-writecache.c                       |  29 +-
 drivers/md/dm-zoned-metadata.c                   |   5 +
 drivers/md/dm-zoned-target.c                     |   3 +-
 drivers/md/dm.c                                  |  12 +-
 drivers/md/persistent-data/dm-space-map-common.c |   2 +
 include/linux/device-mapper.h                    |   3 +-
 include/linux/list.h                             |   2 +-
 include/linux/list_bl.h                          |  26 +
 25 files changed, 1915 insertions(+), 296 deletions(-)
 create mode 100644 Documentation/device-mapper/dm-dust.txt
 create mode 100644 drivers/md/dm-dust.c
