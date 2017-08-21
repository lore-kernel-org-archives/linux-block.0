Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38191 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbdHULni (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 07:43:38 -0400
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org,
        jbacik@fb.com, jikos@kernel.org, benjamin.tissoires@redhat.com,
        manish.chopra@cavium.com, rahul.verma@cavium.com,
        Dept-GELinuxNICDev@cavium.com, harish.patil@cavium.com,
        cascardo@holoscopio.com, don@syst.com.br, dvhart@infradead.org,
        andy@infradead.org, sre@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd-general@lists.sourceforge.net, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/6] drivers:  make device_attribute const
Date: Mon, 21 Aug 2017 17:13:06 +0530
Message-Id: <1503315792-14837-1-git-send-email-bhumirks@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make these const. Done using Coccinelle.

@match disable optional_qualifier@
identifier s;
@@
static struct device_attribute s = {...};

@ref@
position p;
identifier match.s;
@@
s@p

@good1@
identifier match.s;
expression e1;
position ref.p;
@@
device_remove_file(e1,&s@p,...)

@good2@
identifier match.s;
expression e1;
position ref.p;
@@
device_create_file(e1,&s@p,...)


@bad depends on  !good1 && !good2@
position ref.p;
identifier match.s;
@@
s@p

@depends on forall !bad disable optional_qualifier@
identifier match.s;
@@
static
+ const
struct device_attribute s;

Bhumika Goyal (6):
  ACPI: make device_attribute const
  nbd: make device_attribute const
  hid: make device_attribute const
  qlogic:  make device_attribute const
  platform/x86: make device_attribute const
  power: supply: make device_attribute const

 drivers/acpi/battery.c                               | 2 +-
 drivers/acpi/sbs.c                                   | 2 +-
 drivers/block/nbd.c                                  | 2 +-
 drivers/hid/hid-core.c                               | 2 +-
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c | 4 ++--
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c    | 6 +++---
 drivers/platform/x86/classmate-laptop.c              | 6 +++---
 drivers/platform/x86/intel-rst.c                     | 4 ++--
 drivers/power/supply/olpc_battery.c                  | 2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

-- 
1.9.1
