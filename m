Return-Path: <fengguang.wu@intel.com>
Date: Sat, 4 Feb 2017 01:13:55 +0800
From: kbuild test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbuild-all@01.org, Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] genirq/affinity: update CPU affinity for CPU hotplug
 events
Message-ID: <201702040123.XdlQNmj5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
In-Reply-To: <20170203143600.32307-4-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christoph,

[auto build test ERROR on block/for-next]
[also build test ERROR on v4.10-rc6]
[cannot apply to next-20170203]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christoph-Hellwig/genirq-allow-assigning-affinity-to-present-but-not-online-CPUs/20170203-224056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arm-socfpga_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from kernel/irq/internals.h:8:0,
                    from kernel/irq/affinity.c:9:
>> include/linux/irqdesc.h:52:25: error: field 'irq_common_data' has incomplete type
     struct irq_common_data irq_common_data;
                            ^~~~~~~~~~~~~~~
>> include/linux/irqdesc.h:53:19: error: field 'irq_data' has incomplete type
     struct irq_data  irq_data;
                      ^~~~~~~~
>> include/linux/irqdesc.h:55:2: error: unknown type name 'irq_flow_handler_t'
     irq_flow_handler_t handle_irq;
     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/interrupt.h:5:0,
                    from kernel/irq/affinity.c:5:
   include/linux/irqdesc.h: In function 'irq_data_to_desc':
>> include/linux/irqdesc.h:111:26: error: dereferencing pointer to incomplete type 'struct irq_data'
     return container_of(data->common, struct irq_desc, irq_common_data);
                             ^
   include/linux/kernel.h:850:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^~~
   In file included from kernel/irq/internals.h:8:0,
                    from kernel/irq/affinity.c:9:
   include/linux/irqdesc.h: In function 'generic_handle_irq_desc':
>> include/linux/irqdesc.h:150:2: error: called object is not a function or function pointer
     desc->handle_irq(desc);
     ^~~~
   include/linux/irqdesc.h: At top level:
   include/linux/irqdesc.h:194:8: error: unknown type name 'irq_flow_handler_t'
           irq_flow_handler_t handler)
           ^~~~~~~~~~~~~~~~~~
   include/linux/irqdesc.h:215:6: error: unknown type name 'irq_flow_handler_t'
         irq_flow_handler_t handler, const char *name)
         ^~~~~~~~~~~~~~~~~~
   include/linux/irqdesc.h: In function 'irq_balancing_disabled':
>> include/linux/irqdesc.h:229:38: error: 'IRQ_NO_BALANCING_MASK' undeclared (first use in this function)
     return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/irqdesc.h:229:38: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/irqdesc.h: In function 'irq_is_percpu':
>> include/linux/irqdesc.h:237:38: error: 'IRQ_PER_CPU' undeclared (first use in this function)
     return desc->status_use_accessors & IRQ_PER_CPU;
                                         ^~~~~~~~~~~
   In file included from kernel/irq/internals.h:62:0,
                    from kernel/irq/affinity.c:9:
   kernel/irq/debug.h: In function 'print_irq_desc':
>> kernel/irq/debug.h:16:28: warning: format '%p' expects argument of type 'void *', but argument 2 has type 'int' [-Wformat=]
     printk("->handle_irq():  %p, ", desc->handle_irq);
                               ^
>> kernel/irq/debug.h:26:7: error: 'IRQ_LEVEL' undeclared (first use in this function)
     ___P(IRQ_LEVEL);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
>> kernel/irq/debug.h:27:7: error: 'IRQ_PER_CPU' undeclared (first use in this function)
     ___P(IRQ_PER_CPU);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
>> kernel/irq/debug.h:28:7: error: 'IRQ_NOPROBE' undeclared (first use in this function)
     ___P(IRQ_NOPROBE);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
>> kernel/irq/debug.h:29:7: error: 'IRQ_NOREQUEST' undeclared (first use in this function)
     ___P(IRQ_NOREQUEST);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
>> kernel/irq/debug.h:30:7: error: 'IRQ_NOTHREAD' undeclared (first use in this function)
     ___P(IRQ_NOTHREAD);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
>> kernel/irq/debug.h:31:7: error: 'IRQ_NOAUTOEN' undeclared (first use in this function)
     ___P(IRQ_NOAUTOEN);
          ^
   kernel/irq/debug.h:7:50: note: in definition of macro '___P'
    #define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
                                                     ^
   In file included from kernel/irq/internals.h:63:0,
                    from kernel/irq/affinity.c:9:
   kernel/irq/settings.h: At top level:
>> kernel/irq/settings.h:6:28: error: 'IRQ_DEFAULT_INIT_FLAGS' undeclared here (not in a function)
     _IRQ_DEFAULT_INIT_FLAGS = IRQ_DEFAULT_INIT_FLAGS,
                               ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/irq/settings.h:7:18: error: 'IRQ_PER_CPU' undeclared here (not in a function)
     _IRQ_PER_CPU  = IRQ_PER_CPU,
                     ^~~~~~~~~~~
>> kernel/irq/settings.h:8:16: error: 'IRQ_LEVEL' undeclared here (not in a function)
     _IRQ_LEVEL  = IRQ_LEVEL,
                   ^~~~~~~~~
>> kernel/irq/settings.h:9:18: error: 'IRQ_NOPROBE' undeclared here (not in a function)
     _IRQ_NOPROBE  = IRQ_NOPROBE,
                     ^~~~~~~~~~~
>> kernel/irq/settings.h:10:20: error: 'IRQ_NOREQUEST' undeclared here (not in a function)
     _IRQ_NOREQUEST  = IRQ_NOREQUEST,
                       ^~~~~~~~~~~~~
>> kernel/irq/settings.h:11:19: error: 'IRQ_NOTHREAD' undeclared here (not in a function)
     _IRQ_NOTHREAD  = IRQ_NOTHREAD,
                      ^~~~~~~~~~~~

vim +/irq_data +53 include/linux/irqdesc.h

425a5072 Thomas Gleixner           2015-12-13   46   * @rcu:		rcu head for delayed free
ecb3f394 Craig Gallek              2016-09-13   47   * @kobj:		kobject used to represent this struct in sysfs
e144710b Thomas Gleixner           2010-10-01   48   * @dir:		/proc/irq/ procfs entry
e144710b Thomas Gleixner           2010-10-01   49   * @name:		flow handler name for /proc/interrupts output
e144710b Thomas Gleixner           2010-10-01   50   */
e144710b Thomas Gleixner           2010-10-01   51  struct irq_desc {
0d0b4c86 Jiang Liu                 2015-06-01  @52  	struct irq_common_data	irq_common_data;
e144710b Thomas Gleixner           2010-10-01  @53  	struct irq_data		irq_data;
6c9ae009 Eric Dumazet              2011-01-13   54  	unsigned int __percpu	*kstat_irqs;
e144710b Thomas Gleixner           2010-10-01  @55  	irq_flow_handler_t	handle_irq;
78129576 Thomas Gleixner           2011-02-10   56  #ifdef CONFIG_IRQ_PREFLOW_FASTEOI
78129576 Thomas Gleixner           2011-02-10   57  	irq_preflow_handler_t	preflow_handler;
78129576 Thomas Gleixner           2011-02-10   58  #endif
e144710b Thomas Gleixner           2010-10-01   59  	struct irqaction	*action;	/* IRQ action list */
a6967caf Thomas Gleixner           2011-02-10   60  	unsigned int		status_use_accessors;
dbec07ba Thomas Gleixner           2011-02-07   61  	unsigned int		core_internal_state__do_not_mess_with_it;
e144710b Thomas Gleixner           2010-10-01   62  	unsigned int		depth;		/* nested irq disables */
e144710b Thomas Gleixner           2010-10-01   63  	unsigned int		wake_depth;	/* nested wake enables */
e144710b Thomas Gleixner           2010-10-01   64  	unsigned int		irq_count;	/* For detecting broken IRQs */
e144710b Thomas Gleixner           2010-10-01   65  	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
e144710b Thomas Gleixner           2010-10-01   66  	unsigned int		irqs_unhandled;
1e77d0a1 Thomas Gleixner           2013-03-07   67  	atomic_t		threads_handled;
1e77d0a1 Thomas Gleixner           2013-03-07   68  	int			threads_handled_last;
e144710b Thomas Gleixner           2010-10-01   69  	raw_spinlock_t		lock;
31d9d9b6 Marc Zyngier              2011-09-23   70  	struct cpumask		*percpu_enabled;
222df54f Marc Zyngier              2016-04-11   71  	const struct cpumask	*percpu_affinity;
e144710b Thomas Gleixner           2010-10-01   72  #ifdef CONFIG_SMP
e144710b Thomas Gleixner           2010-10-01   73  	const struct cpumask	*affinity_hint;
cd7eab44 Ben Hutchings             2011-01-19   74  	struct irq_affinity_notify *affinity_notify;
e144710b Thomas Gleixner           2010-10-01   75  #ifdef CONFIG_GENERIC_PENDING_IRQ
e144710b Thomas Gleixner           2010-10-01   76  	cpumask_var_t		pending_mask;
e144710b Thomas Gleixner           2010-10-01   77  #endif
e144710b Thomas Gleixner           2010-10-01   78  #endif
b5faba21 Thomas Gleixner           2011-02-23   79  	unsigned long		threads_oneshot;
e144710b Thomas Gleixner           2010-10-01   80  	atomic_t		threads_active;
e144710b Thomas Gleixner           2010-10-01   81  	wait_queue_head_t       wait_for_threads;
cab303be Thomas Gleixner           2014-08-28   82  #ifdef CONFIG_PM_SLEEP
cab303be Thomas Gleixner           2014-08-28   83  	unsigned int		nr_actions;
cab303be Thomas Gleixner           2014-08-28   84  	unsigned int		no_suspend_depth;
17f48034 Rafael J. Wysocki         2015-02-27   85  	unsigned int		cond_suspend_depth;
cab303be Thomas Gleixner           2014-08-28   86  	unsigned int		force_resume_depth;
cab303be Thomas Gleixner           2014-08-28   87  #endif
e144710b Thomas Gleixner           2010-10-01   88  #ifdef CONFIG_PROC_FS
e144710b Thomas Gleixner           2010-10-01   89  	struct proc_dir_entry	*dir;
e144710b Thomas Gleixner           2010-10-01   90  #endif
425a5072 Thomas Gleixner           2015-12-13   91  #ifdef CONFIG_SPARSE_IRQ
425a5072 Thomas Gleixner           2015-12-13   92  	struct rcu_head		rcu;
ecb3f394 Craig Gallek              2016-09-13   93  	struct kobject		kobj;
425a5072 Thomas Gleixner           2015-12-13   94  #endif
293a7a0a Thomas Gleixner           2012-10-16   95  	int			parent_irq;
b6873807 Sebastian Andrzej Siewior 2011-07-11   96  	struct module		*owner;
e144710b Thomas Gleixner           2010-10-01   97  	const char		*name;
e144710b Thomas Gleixner           2010-10-01   98  } ____cacheline_internodealigned_in_smp;
e144710b Thomas Gleixner           2010-10-01   99  
a8994181 Thomas Gleixner           2015-07-05  100  #ifdef CONFIG_SPARSE_IRQ
a8994181 Thomas Gleixner           2015-07-05  101  extern void irq_lock_sparse(void);
a8994181 Thomas Gleixner           2015-07-05  102  extern void irq_unlock_sparse(void);
a8994181 Thomas Gleixner           2015-07-05  103  #else
a8994181 Thomas Gleixner           2015-07-05  104  static inline void irq_lock_sparse(void) { }
a8994181 Thomas Gleixner           2015-07-05  105  static inline void irq_unlock_sparse(void) { }
e144710b Thomas Gleixner           2010-10-01  106  extern struct irq_desc irq_desc[NR_IRQS];
e144710b Thomas Gleixner           2010-10-01  107  #endif
e144710b Thomas Gleixner           2010-10-01  108  
7bbf1dd2 Jiang Liu                 2015-06-01  109  static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
7bbf1dd2 Jiang Liu                 2015-06-01  110  {
755d119a Thomas Gleixner           2015-09-16 @111  	return container_of(data->common, struct irq_desc, irq_common_data);
7bbf1dd2 Jiang Liu                 2015-06-01  112  }
7bbf1dd2 Jiang Liu                 2015-06-01  113  
304adf8a Jiang Liu                 2015-06-04  114  static inline unsigned int irq_desc_get_irq(struct irq_desc *desc)
304adf8a Jiang Liu                 2015-06-04  115  {
304adf8a Jiang Liu                 2015-06-04  116  	return desc->irq_data.irq;
304adf8a Jiang Liu                 2015-06-04  117  }
304adf8a Jiang Liu                 2015-06-04  118  
d9936bb3 Thomas Gleixner           2011-03-11  119  static inline struct irq_data *irq_desc_get_irq_data(struct irq_desc *desc)
d9936bb3 Thomas Gleixner           2011-03-11  120  {
d9936bb3 Thomas Gleixner           2011-03-11  121  	return &desc->irq_data;
d9936bb3 Thomas Gleixner           2011-03-11 @122  }
d9936bb3 Thomas Gleixner           2011-03-11  123  
a0cd9ca2 Thomas Gleixner           2011-02-10  124  static inline struct irq_chip *irq_desc_get_chip(struct irq_desc *desc)
a0cd9ca2 Thomas Gleixner           2011-02-10  125  {
a0cd9ca2 Thomas Gleixner           2011-02-10  126  	return desc->irq_data.chip;
a0cd9ca2 Thomas Gleixner           2011-02-10  127  }
a0cd9ca2 Thomas Gleixner           2011-02-10  128  
a0cd9ca2 Thomas Gleixner           2011-02-10  129  static inline void *irq_desc_get_chip_data(struct irq_desc *desc)
a0cd9ca2 Thomas Gleixner           2011-02-10  130  {
a0cd9ca2 Thomas Gleixner           2011-02-10  131  	return desc->irq_data.chip_data;
a0cd9ca2 Thomas Gleixner           2011-02-10  132  }
a0cd9ca2 Thomas Gleixner           2011-02-10  133  
a0cd9ca2 Thomas Gleixner           2011-02-10  134  static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
a0cd9ca2 Thomas Gleixner           2011-02-10  135  {
af7080e0 Jiang Liu                 2015-06-01  136  	return desc->irq_common_data.handler_data;
a0cd9ca2 Thomas Gleixner           2011-02-10  137  }
a0cd9ca2 Thomas Gleixner           2011-02-10  138  
a0cd9ca2 Thomas Gleixner           2011-02-10  139  static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
a0cd9ca2 Thomas Gleixner           2011-02-10  140  {
b237721c Jiang Liu                 2015-06-01  141  	return desc->irq_common_data.msi_desc;
a0cd9ca2 Thomas Gleixner           2011-02-10  142  }
a0cd9ca2 Thomas Gleixner           2011-02-10  143  
e144710b Thomas Gleixner           2010-10-01  144  /*
e144710b Thomas Gleixner           2010-10-01  145   * Architectures call this to let the generic IRQ layer
6584d84c Huang Shijie              2015-09-01  146   * handle an interrupt.
e144710b Thomas Gleixner           2010-10-01  147   */
bd0b9ac4 Thomas Gleixner           2015-09-14  148  static inline void generic_handle_irq_desc(struct irq_desc *desc)
e144710b Thomas Gleixner           2010-10-01  149  {
bd0b9ac4 Thomas Gleixner           2015-09-14 @150  	desc->handle_irq(desc);
e144710b Thomas Gleixner           2010-10-01  151  }
e144710b Thomas Gleixner           2010-10-01  152  
fe12bc2c Thomas Gleixner           2011-05-18  153  int generic_handle_irq(unsigned int irq);
e144710b Thomas Gleixner           2010-10-01  154  
76ba59f8 Marc Zyngier              2014-08-26  155  #ifdef CONFIG_HANDLE_DOMAIN_IRQ
76ba59f8 Marc Zyngier              2014-08-26  156  /*
76ba59f8 Marc Zyngier              2014-08-26  157   * Convert a HW interrupt number to a logical one using a IRQ domain,
76ba59f8 Marc Zyngier              2014-08-26  158   * and handle the result interrupt number. Return -EINVAL if
76ba59f8 Marc Zyngier              2014-08-26  159   * conversion failed. Providing a NULL domain indicates that the
76ba59f8 Marc Zyngier              2014-08-26  160   * conversion has already been done.
76ba59f8 Marc Zyngier              2014-08-26  161   */
76ba59f8 Marc Zyngier              2014-08-26  162  int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
76ba59f8 Marc Zyngier              2014-08-26  163  			bool lookup, struct pt_regs *regs);
76ba59f8 Marc Zyngier              2014-08-26  164  
76ba59f8 Marc Zyngier              2014-08-26  165  static inline int handle_domain_irq(struct irq_domain *domain,
76ba59f8 Marc Zyngier              2014-08-26  166  				    unsigned int hwirq, struct pt_regs *regs)
76ba59f8 Marc Zyngier              2014-08-26  167  {
76ba59f8 Marc Zyngier              2014-08-26  168  	return __handle_domain_irq(domain, hwirq, true, regs);
76ba59f8 Marc Zyngier              2014-08-26  169  }
76ba59f8 Marc Zyngier              2014-08-26  170  #endif
76ba59f8 Marc Zyngier              2014-08-26  171  
e144710b Thomas Gleixner           2010-10-01  172  /* Test to see if a driver has successfully requested an irq */
f61ae4fb Thomas Gleixner           2015-08-02  173  static inline int irq_desc_has_action(struct irq_desc *desc)
e144710b Thomas Gleixner           2010-10-01  174  {
e144710b Thomas Gleixner           2010-10-01  175  	return desc->action != NULL;
e144710b Thomas Gleixner           2010-10-01  176  }
e144710b Thomas Gleixner           2010-10-01  177  
f61ae4fb Thomas Gleixner           2015-08-02  178  static inline int irq_has_action(unsigned int irq)
f61ae4fb Thomas Gleixner           2015-08-02  179  {
f61ae4fb Thomas Gleixner           2015-08-02  180  	return irq_desc_has_action(irq_to_desc(irq));
f61ae4fb Thomas Gleixner           2015-08-02  181  }
f61ae4fb Thomas Gleixner           2015-08-02  182  
bbc9d21f Thomas Gleixner           2015-06-23  183  /**
bbc9d21f Thomas Gleixner           2015-06-23  184   * irq_set_handler_locked - Set irq handler from a locked region
bbc9d21f Thomas Gleixner           2015-06-23  185   * @data:	Pointer to the irq_data structure which identifies the irq
bbc9d21f Thomas Gleixner           2015-06-23  186   * @handler:	Flow control handler function for this interrupt
bbc9d21f Thomas Gleixner           2015-06-23  187   *
bbc9d21f Thomas Gleixner           2015-06-23  188   * Sets the handler in the irq descriptor associated to @data.
bbc9d21f Thomas Gleixner           2015-06-23  189   *
bbc9d21f Thomas Gleixner           2015-06-23  190   * Must be called with irq_desc locked and valid parameters. Typical
bbc9d21f Thomas Gleixner           2015-06-23  191   * call site is the irq_set_type() callback.
bbc9d21f Thomas Gleixner           2015-06-23  192   */
bbc9d21f Thomas Gleixner           2015-06-23  193  static inline void irq_set_handler_locked(struct irq_data *data,
bbc9d21f Thomas Gleixner           2015-06-23 @194  					  irq_flow_handler_t handler)
bbc9d21f Thomas Gleixner           2015-06-23  195  {
bbc9d21f Thomas Gleixner           2015-06-23  196  	struct irq_desc *desc = irq_data_to_desc(data);
bbc9d21f Thomas Gleixner           2015-06-23  197  
bbc9d21f Thomas Gleixner           2015-06-23  198  	desc->handle_irq = handler;
bbc9d21f Thomas Gleixner           2015-06-23  199  }
bbc9d21f Thomas Gleixner           2015-06-23  200  
bbc9d21f Thomas Gleixner           2015-06-23  201  /**
bbc9d21f Thomas Gleixner           2015-06-23  202   * irq_set_chip_handler_name_locked - Set chip, handler and name from a locked region
bbc9d21f Thomas Gleixner           2015-06-23  203   * @data:	Pointer to the irq_data structure for which the chip is set
bbc9d21f Thomas Gleixner           2015-06-23  204   * @chip:	Pointer to the new irq chip
bbc9d21f Thomas Gleixner           2015-06-23  205   * @handler:	Flow control handler function for this interrupt
bbc9d21f Thomas Gleixner           2015-06-23  206   * @name:	Name of the interrupt
bbc9d21f Thomas Gleixner           2015-06-23  207   *
bbc9d21f Thomas Gleixner           2015-06-23  208   * Replace the irq chip at the proper hierarchy level in @data and
bbc9d21f Thomas Gleixner           2015-06-23  209   * sets the handler and name in the associated irq descriptor.
bbc9d21f Thomas Gleixner           2015-06-23  210   *
bbc9d21f Thomas Gleixner           2015-06-23  211   * Must be called with irq_desc locked and valid parameters.
bbc9d21f Thomas Gleixner           2015-06-23  212   */
bbc9d21f Thomas Gleixner           2015-06-23  213  static inline void
bbc9d21f Thomas Gleixner           2015-06-23  214  irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chip,
bbc9d21f Thomas Gleixner           2015-06-23 @215  				 irq_flow_handler_t handler, const char *name)
bbc9d21f Thomas Gleixner           2015-06-23  216  {
bbc9d21f Thomas Gleixner           2015-06-23  217  	struct irq_desc *desc = irq_data_to_desc(data);
bbc9d21f Thomas Gleixner           2015-06-23  218  
bbc9d21f Thomas Gleixner           2015-06-23  219  	desc->handle_irq = handler;
bbc9d21f Thomas Gleixner           2015-06-23  220  	desc->name = name;
bbc9d21f Thomas Gleixner           2015-06-23  221  	data->chip = chip;
bbc9d21f Thomas Gleixner           2015-06-23  222  }
bbc9d21f Thomas Gleixner           2015-06-23  223  
a2e8461a Thomas Gleixner           2011-03-23  224  static inline int irq_balancing_disabled(unsigned int irq)
a2e8461a Thomas Gleixner           2011-03-23  225  {
e144710b Thomas Gleixner           2010-10-01  226  	struct irq_desc *desc;
e144710b Thomas Gleixner           2010-10-01  227  
e144710b Thomas Gleixner           2010-10-01  228  	desc = irq_to_desc(irq);
0c6f8a8b Thomas Gleixner           2011-03-28 @229  	return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
e144710b Thomas Gleixner           2010-10-01  230  }
78129576 Thomas Gleixner           2011-02-10  231  
7f4a8e7b Vinayak Kale              2013-12-04  232  static inline int irq_is_percpu(unsigned int irq)
7f4a8e7b Vinayak Kale              2013-12-04  233  {
7f4a8e7b Vinayak Kale              2013-12-04  234  	struct irq_desc *desc;
7f4a8e7b Vinayak Kale              2013-12-04  235  
7f4a8e7b Vinayak Kale              2013-12-04  236  	desc = irq_to_desc(irq);
7f4a8e7b Vinayak Kale              2013-12-04 @237  	return desc->status_use_accessors & IRQ_PER_CPU;
7f4a8e7b Vinayak Kale              2013-12-04  238  }
7f4a8e7b Vinayak Kale              2013-12-04  239  
d3e17deb Thomas Gleixner           2011-03-22  240  static inline void

:::::: The code at line 53 was first introduced by commit
:::::: e144710b302525de5b90b9c3ba43562458d8957f genirq: Distangle irq.h

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Iu2NgdlyV/RRVFYdof8BOLE1smtCAQA=

--ZGiS0Q5IWpPtfppv--
