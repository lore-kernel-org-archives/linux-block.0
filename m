Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33698 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdHUM2c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 08:28:32 -0400
MIME-Version: 1.0
In-Reply-To: <1503315792-14837-1-git-send-email-bhumirks@gmail.com>
References: <1503315792-14837-1-git-send-email-bhumirks@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Aug 2017 14:28:31 +0200
Message-ID: <CAJZ5v0jo6q5mniU2HihHcOSqggZ8HFy3mtuo0vXYwuc2tLQ7=w@mail.gmail.com>
Subject: Re: [PATCH 0/6] drivers: make device_attribute const
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jbacik@fb.com,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        manish.chopra@cavium.com, rahul.verma@cavium.com,
        Dept-GELinuxNICDev@cavium.com, harish.patil@cavium.com,
        cascardo@holoscopio.com, don@syst.com.br,
        Darren Hart <dvhart@infradead.org>, andy@infradead.org,
        Sebastian Reichel <sre@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, nbd-general@lists.sourceforge.net,
        linux-input@vger.kernel.org, netdev@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 21, 2017 at 1:43 PM, Bhumika Goyal <bhumirks@gmail.com> wrote:
> Make these const. Done using Coccinelle.
>
> @match disable optional_qualifier@
> identifier s;
> @@
> static struct device_attribute s = {...};
>
> @ref@
> position p;
> identifier match.s;
> @@
> s@p
>
> @good1@
> identifier match.s;
> expression e1;
> position ref.p;
> @@
> device_remove_file(e1,&s@p,...)
>
> @good2@
> identifier match.s;
> expression e1;
> position ref.p;
> @@
> device_create_file(e1,&s@p,...)
>
>
> @bad depends on  !good1 && !good2@
> position ref.p;
> identifier match.s;
> @@
> s@p
>
> @depends on forall !bad disable optional_qualifier@
> identifier match.s;
> @@
> static
> + const
> struct device_attribute s;
>
> Bhumika Goyal (6):
>   ACPI: make device_attribute const
>   nbd: make device_attribute const
>   hid: make device_attribute const
>   qlogic:  make device_attribute const
>   platform/x86: make device_attribute const
>   power: supply: make device_attribute const

It would be better to send these patches separately, because they
touch code maintained by different people and I guess no one will take
the whole series.

I'll take care of the ACPI one, but the rest needs to go in via their
proper trees.

Thanks,
Rafael
