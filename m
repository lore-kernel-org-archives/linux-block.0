Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/6] nbd: make device_attribute const
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
 rjw@rjwysocki.net, lenb@kernel.org, jbacik@fb.com, jikos@kernel.org,
 benjamin.tissoires@redhat.com, manish.chopra@cavium.com,
 rahul.verma@cavium.com, Dept-GELinuxNICDev@cavium.com,
 harish.patil@cavium.com, cascardo@holoscopio.com, don@syst.com.br,
 dvhart@infradead.org, andy@infradead.org, sre@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, nbd-general@lists.sourceforge.net,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
References: <1503315792-14837-1-git-send-email-bhumirks@gmail.com>
 <1503315792-14837-3-git-send-email-bhumirks@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a9b22497-4bbb-d765-249e-5bcddc70fdb6@kernel.dk>
Date: Mon, 28 Aug 2017 15:21:46 -0600
MIME-Version: 1.0
In-Reply-To: <1503315792-14837-3-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/21/2017 05:43 AM, Bhumika Goyal wrote:
> Make this const as is is only passed as an argument to the
> function device_create_file and device_remove_file and the corresponding
> arguments are of type const.
> Done using Coccinelle

Added for 4.14, thanks.

-- 
Jens Axboe
